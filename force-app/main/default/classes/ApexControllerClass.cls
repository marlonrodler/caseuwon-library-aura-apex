public with sharing class ApexControllerClass 
{
    public ApexControllerClass() {

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
    public static Leitor__c atualizaInsereLeitor(Id leitorId, String nome, String sobrenome, String email, String rg, Integer idade) 
    {
        // Instancio um objeto da classe LeitorDAO
        LeitorDAO leitor = new LeitorDAO();
        // Retorno o método criado na classe
        return leitor.atualizaInsereLeitor(leitorId, nome, sobrenome, rg, email, idade);
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


    // CONTROLLER LIVROS
    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna uma lista de Livro
    public static List<Livro__c> buscaLivros() 
    {
        // Instancio um objeto da classe LivroDAO
        LivroDAO livro = new LivroDAO();
        // Retorno o método criado na classe
        return livro.buscaLivros();
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna um único livro, através do parametro livroId
    public static Livro__c buscaLivroPorId(Id livroId) 
    {
        // Instancio um objeto da classe LivroDAO
        LivroDAO livro = new LivroDAO();
        // Retorno o método criado na classe
        return livro.buscaLivroPorId(livroId);
    }
    
    @AuraEnabled
    public static buscaLivrosPorKeyword(String keyword)  {

        LivroDAO livro = new LivroDAO();

        return livro.buscaLivrosPorKeyword(keyword);
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna uma lista de livros, através do parametro titulo
    public static List<Livro__c> buscaLivrosPorTitulo(String titulo) 
    {
        // Instancio um objeto da classe LivroDAO
        LivroDAO livro = new LivroDAO();
        // Retorno o método criado na classe
        return livro.buscaLivrosPorTitulo(titulo);
    }
    
    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna uma lista de livros, através do parametro titulo
    public static List<Livro__c> buscaLivrosPorTituloReserva(String titulo) 
    {
        // Instancio um objeto da classe LivroDAO
        LivroDAO livro = new LivroDAO();
        // Retorno o método criado na classe
        return livro.buscaLivrosPorTituloReserva(titulo);
    }
    
    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que atualiza ou insere livro, retornando um único livro
    public static Livro__c atualizaInsereLivro(Id livroId, String codigo, String titulo, String autor, Integer quantidade, String categoria)
    {
        // Instancio um objeto da classe LivroDAO
        LivroDAO livro = new LivroDAO();
        // Retorno o método criado na classe
        return livro.atualizaInsereLivro(livroId, codigo, titulo, autor, quantidade, categoria);
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático recebe Id como parametro para deletar um livro
    public static void deletaLivro(Id livroId) 
    {
        // Instancio um objeto da classe LivroDAO
        LivroDAO livro = new LivroDAO();
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

    
    // CONTROLLER RESERVAS
    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna uma lista de Reservas
    public static List<Reserva__c> buscaReservas() 
    {
        // Instancio um objeto da classe LivroDAO
        ReservaDAO reserva = new ReservaDAO();
        // Retorno o método criado na classe
        return reserva.buscaReservas();
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna uma lista de Reservas utilizando os parametros definidos
    public static List<Reserva__c> buscaReservasPorKeyword(String keyword, String status)
    {
        // Instancio um objeto da classe LivroDAO
        ReservaDAO reserva = new ReservaDAO();
        // Retorno o método criado na classe
        return reserva.buscaReservasPorKeyword(keyword, status);
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna um Reserva utilizando o parametro definido
    public static Reserva__c buscaReservaPorId(Id reservaId) 
    {
        // Instancio um objeto da classe LivroDAO
        ReservaDAO reserva = new ReservaDAO();
        // Retorno o método criado na classe
        return reserva.buscaReservaPorId(reservaId);
    }
    
    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna um Reserva utilizando os parametros definidos
    public static Reserva__c atualizaInsereReserva(Id reservaId, Id livroId, Id leitorId, String status) 
    {
        // Instancio um objeto da classe LivroDAO
        ReservaDAO reserva = new ReservaDAO();
        // Retorno o método criado na classe
        return reserva.atualizaInsereReserva(reservaId, livroId, leitorId, status);
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que realiza o delete de um reserva através do parametro definido
    public static void deletaReserva(Id reservaId) 
    {
        // Instancio um objeto da classe LivroDAO
        ReservaDAO reserva = new ReservaDAO();
        // Chamo o delete de reserva
        reserva.deletaReserva(reservaId);
    }
    // CONTROLLER RESERVAS


    // CONTROLLER PERIODICO
    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna uma lista de Periodicos
    public static List<Periodico__c> buscaPeriodicos() 
    {
        // Instancio um objeto da classe PeriodicoDAO
        PeriodicoDAO periodico = new PeriodicoDAO();
        // Retorno o método criado na classe
        return periodico.buscaPeriodicos();
    }


    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna um Reserva utilizando o parametro definido
    public static Periodico__c buscaPeriodicoPorId(Id periodicoId) 
    {
        // Instancio um objeto da classe PeriodicoDAO
        PeriodicoDAO periodico = new PeriodicoDAO();
        // Retorno o método criado na classe
        return periodico.buscaPeriodicoPorId(periodicoId);
    }
    
    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que realiza o delete de um periodico através do parametro definido
    public static void deletaPeriodico(Id periodicoId) 
    {
        // Instancio um objeto da classe LivroDAO
        PeriodicoDAO periodico = new PeriodicoDAO();
        // Chamo o delete de periodico
        periodico.deletaPeriodico(periodicoId);
    }

    @AuraEnabled
    // Metodo estático que retorna um Periodico utilizando os parametros definidos
    public static Periodico__c atualizaInserePeriodico(Id periodicoId, String nome, String categoria) 
    {
        // Instancio um objeto da classe PeriodicoDAO
        PeriodicoDAO periodico = new PeriodicoDAO();
        // Retorno o método criado na classe
        return periodico.atualizaInserePeriodico(periodicoId, nome, categoria);
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna um único nome, através do parametro nome
    public static List<Periodico__c> buscaPeriodicosPorNome(String nome) 
    {
        // Instancio um objeto da classe PeriodicoDAO
        PeriodicoDAO periodico = new PeriodicoDAO();
        // Retorno o método criado na classe
        return periodico.buscaPeriodicosPorNome(nome);
    }


       // CONTROLLER ASSINATURAS
    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna uma lista de Assinaturas
    public static List<Assinatura__c> buscaAssinaturas() 
    {
        // Instancio um objeto da classe LivroDAO
        AssinaturaDAO assinatura = new AssinaturaDAO();
        // Retorno o método criado na classe
        return assinatura.buscaAssinaturas();
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna uma lista de Assinaturas utilizando os parametros definidos
    public static List<Assinatura__c> buscaAssinaturasPorKeyword(String keyword, String status)
    {
        // Instancio um objeto da classe LivroDAO
        AssinaturaDAO assinatura = new AssinaturaDAO();
        // Retorno o método criado na classe
        return assinatura.buscaAssinaturasPorKeyword(keyword, status);
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna um Assinatura utilizando o parametro definido
    public static Assinatura__c buscaAssinaturaPorId(Id assinaturaId) 
    {
        // Instancio um objeto da classe LivroDAO
        AssinaturaDAO assinatura = new AssinaturaDAO();
        // Retorno o método criado na classe
        return assinatura.buscaAssinaturaPorId(assinaturaId);
    }
    
    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que retorna um Assinatura utilizando os parametros definidos
    public static Assinatura__c atualizaInsereAssinatura(Id assinaturaId, Id periodicoId, Id leitorId, String tipoAssinatura) 
    {
        // Instancio um objeto da classe LivroDAO
        AssinaturaDAO assinatura = new AssinaturaDAO();
        // Retorno o método criado na classe
        return assinatura.atualizaInsereAssinatura(assinaturaId, periodicoId, leitorId, tipoAssinatura);
    }

    // Deixo disponível para o Aura Component
    @AuraEnabled
    // Metodo estático que realiza o delete de um assinatura através do parametro definido
    public static void deletaAssinatura(Id assinaturaId) 
    {
        // Instancio um objeto da classe LivroDAO
        AssinaturaDAO assinatura = new AssinaturaDAO();
        // Chamo o delete de assinatura
        assinatura.deletaAssinatura(assinaturaId);
    }
    // CONTROLLER ASSINATURAS
}
