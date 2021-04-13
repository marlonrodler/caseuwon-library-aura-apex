public with sharing class ApexControllerClass 
{
    public ApexControllerClass() {

    }

    // CONTROLLER LEITORES
    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna uma lista de Leitor
    public static List<Leitor__c> buscaLeitores() 
    {
        // Instancio um objeto da classe LeitorServiceClass
        LeitorServiceClass leitor = new LeitorServiceClass();
        // Retorno o método criado na classe
        return leitor.buscaLeitores();
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna um único leitor, através do parametro leitorId
    public static Leitor__c buscaLeitorPorId(Id leitorId) 
    {
        // Instancio um objeto da classe LeitorServiceClass
        LeitorServiceClass leitor = new LeitorServiceClass();
        // Retorno o método criado na classe
        return leitor.buscaLeitorPorId(leitorId);
    }
    
    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna um único nome, através do parametro nome
    public static List<Leitor__c> buscaLeitoresPorNome(String nome) 
    {
        // Instancio um objeto da classe LeitorServiceClass
        LeitorServiceClass leitor = new LeitorServiceClass();
        // Retorno o método criado na classe
        return leitor.buscaLeitoresPorNome(nome);
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que atualiza ou insere leitor, retornando um único leitor
    public static Leitor__c atualizaInsereLeitor(Id leitorId, String nome, String sobrenome, String rg, Integer idade) 
    {
        // Instancio um objeto da classe LeitorServiceClass
        LeitorServiceClass leitor = new LeitorServiceClass();
        // Retorno o método criado na classe
        return leitor.atualizaInsereLeitor(leitorId, nome, sobrenome, rg, idade);
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático recebe Id como parametro para deletar um leitor
    public static void deletaLeitor(Id leitorId) 
    {
        // Instancio um objeto da classe LeitorServiceClass
        LeitorServiceClass leitor = new LeitorServiceClass();
        // Chamo o método deletar da classe instanciada
        leitor.deletaLeitor(leitorId);
    }
    // CONTROLLER LEITORES


    // CONTROLLER LIVROS
    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna uma lista de Livro
    public static List<Livro__c> buscaLivros() 
    {
        // Instancio um objeto da classe LivroServiceClass
        LivroServiceClass livro = new LivroServiceClass();
        // Retorno o método criado na classe
        return livro.buscaLivros();
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna um único livro, através do parametro livroId
    public static Livro__c buscaLivroPorId(Id livroId) 
    {
        // Instancio um objeto da classe LivroServiceClass
        LivroServiceClass livro = new LivroServiceClass();
        // Retorno o método criado na classe
        return livro.buscaLivroPorId(livroId);
    }
    
    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna uma lista de livros, através do parametro titulo
    public static List<Livro__c> buscaLivrosPorTitulo(String titulo) 
    {
        // Instancio um objeto da classe LivroServiceClass
        LivroServiceClass livro = new LivroServiceClass();
        // Retorno o método criado na classe
        return livro.buscaLivrosPorTitulo(titulo);
    }
    
    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que atualiza ou insere livro, retornando um único livro
    public static Livro__c atualizaInsereLivro(Id livroId, String codigo, String titulo, String autor, Integer quantidade) 
    {
        // Instancio um objeto da classe LivroServiceClass
        LivroServiceClass livro = new LivroServiceClass();
        // Retorno o método criado na classe
        return livro.atualizaInsereLivro(livroId, codigo, titulo, autor, quantidade);
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático recebe Id como parametro para deletar um livro
    public static void deletaLivro(Id livroId) 
    {
        // Instancio um objeto da classe LivroServiceClass
        LivroServiceClass livro = new LivroServiceClass();
        // Chamo o método deletar da classe instanciada
        livro.deletaLivro(livroId);
    }
    // CONTROLLER LIVROS


    // CONTROLLER EMPRESTIMOS
    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna uma lista de Emprestimos
    public static List<Emprestimo__c> buscaEmprestimos() 
    {
        // Instancio um objeto da classe LivroServiceClass
        EmprestimoServiceClass emprestimo = new EmprestimoServiceClass();
        // Retorno o método criado na classe
        return emprestimo.buscaEmprestimos();
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna uma lista de Emprestimos utilizando os parametros definidos
    public static List<Emprestimo__c> buscaEmprestimosPorKeyword(String keyword, String status)
    {
        // Instancio um objeto da classe LivroServiceClass
        EmprestimoServiceClass emprestimo = new EmprestimoServiceClass();
        // Retorno o método criado na classe
        return emprestimo.buscaEmprestimosPorKeyword(keyword, status);
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna um Emprestimo utilizando o parametro definido
    public static Emprestimo__c buscaEmprestimoPorId(Id emprestimoId) 
    {
        // Instancio um objeto da classe LivroServiceClass
        EmprestimoServiceClass emprestimo = new EmprestimoServiceClass();
        // Retorno o método criado na classe
        return emprestimo.buscaEmprestimoPorId(emprestimoId);
    }
    
    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna um Emprestimo utilizando os parametros definidos
    public static Emprestimo__c atualizaInsereEmprestimo(Id emprestimoId, Id livroId, Id leitorId, Boolean devolvido) 
    {
        // Instancio um objeto da classe LivroServiceClass
        EmprestimoServiceClass emprestimo = new EmprestimoServiceClass();
        // Retorno o método criado na classe
        return emprestimo.atualizaInsereEmprestimo(emprestimoId, livroId, leitorId, devolvido);
    }
    
    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna uma String utilizando o parametro definido
    public static String devolveEmprestimo(List<Id> emprestimoIds)  
    {
        // Instancio um objeto da classe LivroServiceClass
        EmprestimoServiceClass emprestimo = new EmprestimoServiceClass();
        // Retorno o método criado na classe
        return emprestimo.devolveEmprestimo(emprestimoIds);
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que realiza o delete de um emprestimo através do parametro definido
    public static void deletaEmprestimo(Id emprestimoId) 
    {
        // Instancio um objeto da classe LivroServiceClass
        EmprestimoServiceClass emprestimo = new EmprestimoServiceClass();
        // Chamo o delete de emprestimo
        emprestimo.deletaEmprestimo(emprestimoId);
    }
    // CONTROLLER EMPRESTIMOS
}
