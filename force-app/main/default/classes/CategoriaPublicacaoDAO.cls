public with sharing class CategoriaPublicacaoDAO {
    public CategoriaPublicacaoDAO() {

    }

    // Defino método para retornar uma Categoria que tenha id igual a categoria_publicacaoId
    public List<CategoriaPublicacao__c> buscaCetgoriaPublicacaoPorId(Id categoria_publicacaoId){
        return [
            SELECT 
                id, 
                Categoria__c,
                Publicacao__c           
            FROM 
            CategoriaPublicacao__c
            WHERE id =: categoria_publicacaoId
            LIMIT 1
        ];
    }

    public CategoriaPublicacao__c atualizaInsereCategoria(Id categoria_publicacaoId, Id categoria, Id publicacao){
        // Instancio meu objeto categoria
        CategoriaPublicacao__c categoria_publicacao = new CategoriaPublicacao__c();

        // Verifico se o parametro categoria_publicacaoId não está vindo como nulo (vazio)
        if (categoria_publicacaoId != null)
        {
            // Se sim, faço uma busca da categoria por ID, atribuindo os valores de retorno para "categoria"
            categoria_publicacao = buscaCetgoriaPublicacaoPorId(categoria_publicacaoId);
        }

        if (categoria != null)
        {
            categoria_publicacao.Categoria__c = categoria;
        }

        if (publicacao != null)
        {
            categoria_publicacao.Categoria__c = publicacao;
        }

        try {
            // Realizo o upsert de "categoria"
            upsert categoria_publicacao;
        } catch (Exception e) {
            throw new categoriaDAOException('Falha. O(s) seguinte(s) erro(s) foram encontrados: ' + e.getMessage());
        }

        return buscaCetgoriaPublicacaoPorId(categoria_publicacao.Id);
    }

    public void deletaCategoria(Id categoria_publicacaoId){
        // Busco uma categoria por Id
        CategoriaPublicacao__c categoria_publicacao = buscaCetgoriaPublicacaoPorId(categoria_publicacaoId);

        delete categoria_publicacao;
    }
}
