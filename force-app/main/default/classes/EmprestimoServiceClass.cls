public with sharing class EmprestimoServiceClass 
{
    public EmprestimoServiceClass() 
    {

    }

    // Defino método para retornar uma lista de Emprestimos
    public List<Emprestimo__c> buscaEmprestimos() 
    {
        return [
            SELECT 
                id,
                Livro__c,
                Leitor__c,
                Livro__r.Titulo__c,
                Livro__r.Autor__c,
                Leitor__r.Nome__c,
                Leitor__r.Sobrenome__c,
                Devolvido__c,
                DataEmprestimo__c,
                DataDevolucao__c
            FROM 
                Emprestimo__c
            ORDER BY Name DESC
        ];
    }
    
    // Defino método para retornar uma lista de Emprestimos relacionadas com os parametros que defino
    public List<Emprestimo__c> buscaEmprestimosPorKeyword(String keyword, String status) 
    {
        // Defino dois filtros para validar com o campo Devolver__c
        Boolean filter = true;
        Boolean auxFilter = false;

        // Concateno meu keyword com '%', ficando '%keyword%'
        keyword = '%'+keyword+'%';

        // Valido qual o valor que está vindo em status
        if (status == 'T') 
        {
            // Atribuo true para auxFilter
            auxFilter = true;
        }
        else if (status == 'F') 
        {
            // Atribuo true para filter
            filter = false;
        }

        return [
            SELECT 
                id,
                Livro__c,
                Leitor__c,
                Livro__r.Titulo__c,
                Livro__r.Autor__c,
                Leitor__r.Nome__c,
                Leitor__r.Sobrenome__c,
                Devolvido__c,
                DataEmprestimo__c,
                DataDevolucao__c
            FROM 
                Emprestimo__c
            WHERE 
                (
                    Livro__r.Titulo__c LIKE :keyword OR 
                    Leitor__r.Nome__c LIKE :keyword OR 
                    Leitor__r.Sobrenome__c LIKE :keyword
                )
                AND
                (
                    Devolvido__c =: filter OR 
                    Devolvido__c =: auxFilter 
                )
            ORDER BY Name DESC
        ];
    }

    // Defino método para retornar um Emprestimos que tenha id igual a emprestimoId
    public Emprestimo__c buscaEmprestimoPorId(Id emprestimoId) 
    {
        return [
            SELECT 
                id, 
                Livro__c,
                Leitor__c,
                Livro__r.Titulo__c,
                Livro__r.Autor__c,
                Leitor__r.Nome__c,
                Leitor__r.Sobrenome__c,
                Devolvido__c,
                DataEmprestimo__c,
                DataDevolucao__c
            FROM 
                Emprestimo__c
            WHERE id =: emprestimoId
            LIMIT 1
        ];
    }
    
    // Defino método para retornar uma lista de Emprestimos que tenha Livro__c igual a livroId
    public List<Emprestimo__c> buscaEmprestimoPorLivro(Id livroId) 
    {
        return [
            SELECT 
                id, 
                Livro__c,
                Leitor__c,
                Livro__r.Titulo__c,
                Livro__r.Autor__c,
                Leitor__r.Nome__c,
                Leitor__r.Sobrenome__c,
                Devolvido__c,
                DataEmprestimo__c,
                DataDevolucao__c
            FROM 
                Emprestimo__c
            WHERE Livro__c =: livroId
        ];
    }
    
    // Defino método para retornar uma lista de Emprestimos que tenha Leitor__c igual a leitorId
    public List<Emprestimo__c> buscaEmprestimoPorLeitor(Id leitorId) 
    {
        return [
            SELECT 
                id, 
                Livro__c,
                Leitor__c,
                Livro__r.Titulo__c,
                Livro__r.Autor__c,
                Leitor__r.Nome__c,
                Leitor__r.Sobrenome__c,
                Devolvido__c,
                DataEmprestimo__c,
                DataDevolucao__c
            FROM 
                Emprestimo__c
            WHERE Leitor__c =: leitorId
        ];
    }
    
    // Defino um método que recebe uma lista do tipo id chamada emprestimoIds 
    public String devolveEmprestimo(List<Id> emprestimoIds) 
    {
        // Instancio uma lista de emprestimos
        List<Emprestimo__c> emprestimos = new List<Emprestimo__c>();

        // Instacio minha classe LivroServiceClass
        LivroServiceClass livro = new LivroServiceClass();

        // Verifico se minha lista de emprestimoIds é vazia
        if (emprestimoIds.isEmpty()) 
        {
            throw new EmprestimoServiceClassException('Adicione pelo menos um livro para a devolução');
        }

        // Percorro minha lista emprestimoIds
        for (Id emprestimoId : emprestimoIds) 
        {
            // Adiciono na minha lista uma instacia de Emprestimo, já setando em seu construtor qual a alteração dos campos
            emprestimos.add(new Emprestimo__c(Id = emprestimoId, Devolvido__c = true));

            // Busco o empretimo por Id, passando para rsEmprestimo
            Emprestimo__c rsEmprestimo = buscaEmprestimoPorId(emprestimoId);

            // Busco o livro por Id, passando para rsLivro
            Livro__c rsLivro = livro.buscaLivroPorId(rsEmprestimo.Livro__c);

            // Atualizo o rsLivro
            update rsLivro;
        }

        // Atualizo o emprestimos
        update emprestimos;

        return 'Livro(s) devolvidos com sucesso!';
    }

    // Defino método para atualizar ou inserir um emprestimo
    public Emprestimo__c atualizaInsereEmprestimo(Id emprestimoId, Id livroId, Id leitorId, Boolean devolvido) 
    {
        // Instacio minha classe LivroServiceClass
        LivroServiceClass livro = new LivroServiceClass();

        // Instancio um emprestimo
        Emprestimo__c emprestimo = new Emprestimo__c();

        // Verifico se o parametro emprestimoId não está vindo como nulo (vazio)
        if (emprestimoId != null)
        {
            // Faço uma busca do emprestimo por ID, atribuindo os valores de retorno para "emprestimo"
            emprestimo = buscaEmprestimoPorId(emprestimoId);
        } 
        else 
        {
            // Verifico se o parametro livroId não está vindo como nulo (vazio)
            if (livroId != null) 
            {
                // Atribuo livroId para o Livro__c de emprestimo
                emprestimo.Livro__c = livroId;
            }
            // Verifico se o parametro livroId não está vindo como nulo (vazio)
            if (leitorId != null) 
            {
                // Atribuo leitorId para o Leitor__c de emprestimo
                emprestimo.Leitor__c = leitorId;
            }
        }
        
        // Verifico se o parametro livroId não está vindo como nulo (vazio)
        if (livroId != null) 
        {
            //Faço uma busca de livro por ID, atribuindo os valores de retorno para "rsLivro"
            Livro__c rsLivro = livro.buscaLivroPorId(livroId);

            // Valido se o parametro "devolvido" é falso
            if (devolvido != true) 
            {
                // Verifico se calcQuantidade é menor que 0
                if (rsLivro.QuantidadeDisponivel__c == 0) 
                {
                    throw new EmprestimoServiceClassException('Livro não disponível');
                }
            }
            // Realizo o update de rsLivro
            update rsLivro;
        }

        // Verifico se o devolvido é diferente de nulo
        if (devolvido != null) 
        {
            // Atribuo o devolvido para o campo emprestimo.Devolvido__c
            emprestimo.Devolvido__c = devolvido;
        }

        try {
            // Realizo o upsert de "emprestimo"
            upsert emprestimo;
        } catch (DmlException e) {
            // Realizo um throw, instaciando um Exception customizado e atribuindo uma mensagem para ele
            throw new EmprestimoServiceClassException('Entrar em contato com o suporte');
        }

        return buscaEmprestimoPorId(emprestimo.Id);
    }

    // Defino método para deletar um Emprestimo através do parametro emprestimoId
    public void deletaEmprestimo(Id emprestimoId) 
    {
        // Busco um emprestimo por Id
        Emprestimo__c emprestimo = buscaEmprestimoPorId(emprestimoId);

        // Valido se o Devolvido é false, para nao deixa-lo ser excluido
        if (emprestimo.Devolvido__c == false) {
            throw new EmprestimoServiceClassException('Você não pode deletar um livro pendente de devolução');
        }

        delete emprestimo;
    }

    // Defino um método EmprestimoServiceClassException que puxa as especificidades da classe Exception 
    public class EmprestimoServiceClassException extends Exception {}
}