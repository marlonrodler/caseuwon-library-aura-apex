public with sharing class LivroController {
    public LivroController() {

    }

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
}
