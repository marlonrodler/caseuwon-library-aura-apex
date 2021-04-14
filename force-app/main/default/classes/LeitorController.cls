public with sharing class LeitorController {
    public LeitorController() {

    }


    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna uma lista de Leitor
    public static List<Leitor__c> buscaLeitores() 
    {
        // Instancio um objeto da classe LeitorDAO
        LeitorDAO leitor = new LeitorDAO();
        // Retorno o método criado na classe
        return leitor.buscaLeitores();
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna um único leitor, através do parametro leitorId
    public static Leitor__c buscaLeitorPorId(Id leitorId) 
    {
        // Instancio um objeto da classe LeitorDAO
        LeitorDAO leitor = new LeitorDAO();
        // Retorno o método criado na classe
        return leitor.buscaLeitorPorId(leitorId);
    }
    
    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna um único nome, através do parametro nome
    public static List<Leitor__c> buscaLeitoresPorNome(String nome) 
    {
        // Instancio um objeto da classe LeitorDAO
        LeitorDAO leitor = new LeitorDAO();
        // Retorno o método criado na classe
        return leitor.buscaLeitoresPorNome(nome);
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que atualiza ou insere leitor, retornando um único leitor
    public static Leitor__c atualizaInsereLeitor(Id leitorId, String nome, String sobrenome, String rg, Integer idade) 
    {
        // Instancio um objeto da classe LeitorDAO
        LeitorDAO leitor = new LeitorDAO();
        // Retorno o método criado na classe
        return leitor.atualizaInsereLeitor(leitorId, nome, sobrenome, rg, idade);
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático recebe Id como parametro para deletar um leitor
    public static void deletaLeitor(Id leitorId) 
    {
        // Instancio um objeto da classe LeitorDAO
        LeitorDAO leitor = new LeitorDAO();
        // Chamo o método deletar da classe instanciada
        leitor.deletaLeitor(leitorId);
    }
}
