public with sharing class EmprestimoController {
    public EmprestimoController() {

    }

    // CONTROLLER EMPRESTIMOS
    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna uma lista de Emprestimos
    public static List<Emprestimo__c> buscaEmprestimos() 
    {
        // Instancio um objeto da classe LivroDAO
        EmprestimoDAO emprestimo = new EmprestimoDAO();
        // Retorno o método criado na classe
        return emprestimo.buscaEmprestimos();
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna uma lista de Emprestimos utilizando os parametros definidos
    public static List<Emprestimo__c> buscaEmprestimosPorKeyword(String keyword, String status)
    {
        // Instancio um objeto da classe LivroDAO
        EmprestimoDAO emprestimo = new EmprestimoDAO();
        // Retorno o método criado na classe
        return emprestimo.buscaEmprestimosPorKeyword(keyword, status);
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna um Emprestimo utilizando o parametro definido
    public static Emprestimo__c buscaEmprestimoPorId(Id emprestimoId) 
    {
        // Instancio um objeto da classe LivroDAO
        EmprestimoDAO emprestimo = new EmprestimoDAO();
        // Retorno o método criado na classe
        return emprestimo.buscaEmprestimoPorId(emprestimoId);
    }
    
    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna um Emprestimo utilizando os parametros definidos
    public static Emprestimo__c atualizaInsereEmprestimo(Id emprestimoId, Id livroId, Id leitorId, Boolean devolvido) 
    {
        // Instancio um objeto da classe LivroDAO
        EmprestimoDAO emprestimo = new EmprestimoDAO();
        // Retorno o método criado na classe
        return emprestimo.atualizaInsereEmprestimo(emprestimoId, livroId, leitorId, devolvido);
    }
    
    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna uma String utilizando o parametro definido
    public static String devolveEmprestimo(List<Id> emprestimoIds)  
    {
        // Instancio um objeto da classe LivroDAO
        EmprestimoDAO emprestimo = new EmprestimoDAO();
        // Retorno o método criado na classe
        return emprestimo.devolveEmprestimo(emprestimoIds);
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que realiza o delete de um emprestimo através do parametro definido
    public static void deletaEmprestimo(Id emprestimoId) 
    {
        // Instancio um objeto da classe LivroDAO
        EmprestimoDAO emprestimo = new EmprestimoDAO();
        // Chamo o delete de emprestimo
        emprestimo.deletaEmprestimo(emprestimoId);
    }
    // CONTROLLER EMPRESTIMOS
}
