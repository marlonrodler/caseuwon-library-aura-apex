public with sharing class LeitorServiceClass 
{
    public LeitorServiceClass() {

    }

    // Defino método para retornar uma lista de Leitor
    public List<Leitor__c> buscaLeitores() 
    {
        return [
            SELECT 
                id, 
                Nome__c,
                Sobrenome__c,
                RG__c,
                Idade__c
            FROM 
                Leitor__c
            ORDER BY Name DESC
        ];
    }

    // Defino método para retornar um unico leitor pelo seu ID através do parametro leitorId
    public Leitor__c buscaLeitorPorId(Id leitorId) 
    {
        return [
            SELECT 
                id, 
                Nome__c,
                Sobrenome__c,
                RG__c,
                Idade__c
            FROM 
                Leitor__c
            WHERE id =: leitorId
        ];
    }
    
    // Defino método para retornar uma lista leitor pelo seu Nome através do parametro nome
    public List<Leitor__c> buscaLeitoresPorNome(String nome) 
    {
        nome = '%'+nome+'%';
        return [
            SELECT 
                id, 
                Nome__c,
                Sobrenome__c,
                RG__c,
                Idade__c
            FROM 
                Leitor__c
            WHERE Nome__c LIKE :nome
        ];
    }

    // Defino método para atualizar ou inserir um Leitor
    public Leitor__c atualizaInsereLeitor(Id leitorId, String nome, String sobrenome, String rg, Integer idade) 
    {
        // Instancio meu objeto leitor
        Leitor__c leitor = new Leitor__c();

        // Verifico se o parametro leitorId não está vindo como nulo (vazio)
        if (leitorId != null)
        {
            // Se sim, faço uma busca do leitor por ID, atribuindo os valores de retorno para "leitor"
            leitor = buscaLeitorPorId(leitorId);
        }
        
        // Verifico se os parametros possuem valor, caso sim, substituem o valor dos campos do objeto "leitor"
        if (nome != '') 
        {
            leitor.Nome__c = nome;
        }

        if (sobrenome != '') 
        {
            leitor.Sobrenome__c = sobrenome;
        }

        if (rg != '') 
        {
            leitor.RG__c = rg;
        }

        if (idade != null) 
        {
            leitor.Idade__c = idade;
        }

        try {
            // Realizo o upsert de "leitor"
            upsert leitor;
        } catch (DmlException e) {
            // Realizo um throw, instaciando um Exception customizado e atribuindo uma mensagem para ele
            throw new LeitorServiceClassException('Já possui um registro com o RG: ' + rg);
        }

        // Retorno a lista do Leitor que foi inserido ou atualizado através do método buscaLeitorPorId()
        return buscaLeitorPorId(leitor.Id);
    }

    // Defino método para deletar um Leitor através do parametro leitorId
    public void deletaLeitor(Id leitorId) 
    {
        // Instancio a classe EmprestimoServiceClass para utilizar seus métodos
        EmprestimoServiceClass emprestimo = new EmprestimoServiceClass();

        // Instancio um objeto Leitor para realizar a chamada do método buscaLeitorPorId
        Leitor__c leitor = buscaLeitorPorId(leitorId);

        // Verifico se possui um leitor que realizou um empréstimo, validando através do método
        // buscaEmprestimoPorLeitor, caso seja vazio, executa o que está dentro da condição
        if ( !emprestimo.buscaEmprestimoPorLeitor(leitorId).isEmpty() ) 
        {
            // Realizo um throw, instaciando um Exception customizado e atribuindo uma mensagem para ele
            throw new LeitorServiceClassException('Leitor não pode ser deletado, há empréstimos associados.');
        } 

        // Realizo o delete de "leitor"
        delete leitor;
    }

    // Defino um método LeitorServiceClassException que puxa as especificidades da classe Exception 
    public class LeitorServiceClassException extends Exception {}
}