public with sharing class LivroServiceClass 
{
    public LivroServiceClass() {

    }

    // Defino método para retornar uma lista de Livros
    public List<Livro__c> buscaLivros() 
    {
        return [
            SELECT 
                id, 
                Codigo__c,
                Titulo__c,
                Autor__c,
                Quantidade__c,
                QuantidadeDisponivel__c,
                QuantidadeEmprestada__c
            FROM 
                Livro__c
            ORDER BY Name DESC
        ];
    }

    // Defino método para retornar um unico livro pelo seu ID através do parametro livroId
    public Livro__c buscaLivroPorId(Id livroId) 
    {
        return [
            SELECT 
                id, 
                Codigo__c,
                Titulo__c,
                Autor__c,
                Quantidade__c,
                QuantidadeDisponivel__c,
                QuantidadeEmprestada__c
            FROM 
                Livro__c
            WHERE id =: livroId
        ];
    }
    
    // Defino método para retornar um unico livro pelo seu CODIGO através do parametro codigo
    public Livro__c buscaLivroPorCodigo(String codigo) 
    {
        return [
            SELECT 
                id, 
                Codigo__c,
                Titulo__c,
                Autor__c,
                Quantidade__c,
                QuantidadeDisponivel__c,
                QuantidadeEmprestada__c
            FROM 
                Livro__c
            WHERE id =: codigo
        ];
    }

    // Defino método para retornar uma lista de livro pelo seu Titulo através do parametro titulo
    public List<Livro__c> buscaLivrosPorTitulo(String titulo) 
    {
        titulo = '%'+titulo+'%';
        return [
            SELECT 
                id, 
                Codigo__c,
                Titulo__c,
                Autor__c,
                Quantidade__c,
                QuantidadeDisponivel__c,
                QuantidadeEmprestada__c
            FROM 
                Livro__c
            WHERE 
                Titulo__c LIKE :titulo AND
                QuantidadeDisponivel__c > 0
        ];
    }

    // Defino método para atualizar ou inserir um Livro
    public Livro__c atualizaInsereLivro(Id livroId, String codigo, String titulo, String autor, Integer quantidade) 
    {
        // Instancio meu objeto livro
        Livro__c livro = new Livro__c();

        // Tratamento caso a quantidade venha vazia
        if (quantidade == null) {
            quantidade = 0;
        }

        // Verifico se o parametro livroId não está vindo como nulo (vazio)
        if (livroId != null)
        {
            // Se sim, faço uma busca do livro por ID, atribuindo os valores de retorno para "li"
            livro = buscaLivroPorId(livroId);
        } 

        // Verifico se os parametros possuem valor, caso sim, substituem o valor dos campos do objeto "livro"
        if (codigo != '') 
        {
            livro.Codigo__c = codigo;
        }

        if (titulo != '') 
        {
            livro.Titulo__c = titulo;
        }

        if (autor != '') 
        {
            livro.Autor__c = autor;
        }

        if (quantidade != null) 
        {
            livro.Quantidade__c = quantidade;
        }

        // Valido se QuantidadeDisponivel__c é menor que 0 (zero), caso seja, disparo um erro
        if ( livro.QuantidadeDisponivel__c < 0 ) 
        {
            // Realizo um throw, instaciando um Exception customizado e atribuindo uma mensagem para ele
            throw new LivroServiceClassException('Verifique sua quantidade disponível, não pode ser menor que 0 (zero).');
        }

        try {
            // Realizo o upsert de "livro"
            upsert livro;
        } catch (DmlException e) {
            // Realizo um throw, instaciando um Exception customizado e atribuindo uma mensagem para ele
            throw new LivroServiceClassException('Já possui um registro com o código: ' + codigo);
        }

        // Retorno o Livro que foi inserido ou atualizado através do método buscaLivroPorId()
        return buscaLivroPorId(livro.Id);
    }

    // Defino método para deletar um Livro através do parametro livroId
    public void deletaLivro(Id livroId) 
    {
        // Instancio a classe EmprestimoServiceClass para utilizar seus métodos
        EmprestimoServiceClass emprestimo = new EmprestimoServiceClass();

        // Instancio um objeto Livro para realizar a chamada do método buscaLivroPorId
        Livro__c livro = buscaLivroPorId(livroId);

        // Verifico se possui um livro que está emprestimo um empréstimo, validando através do método
        // buscaEmprestimoPorLivro, caso seja vazio, executa o que está dentro da condição
        if ( !emprestimo.buscaEmprestimoPorLivro(livroId).isEmpty() ) 
        {
            // Realizo um throw, instaciando um Exception customizado e atribuindo uma mensagem para ele
            throw new LivroServiceClassException('Livro não pode ser deletado, há empréstimos associados.');
        } 

        // Realizo o delete de "livro"
        delete livro;
    }
    
    // Defino um método LivroServiceClassException que puxa as especificidades da classe Exception 
    public class LivroServiceClassException extends Exception {}
}