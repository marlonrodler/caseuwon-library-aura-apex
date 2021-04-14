public with sharing class CategoriaDAO {
    public CategoriaDAO() {

    }
    
    // Defino método para retornar uma Categoria que tenha id igual a categoriaId
    public List<Categoria__c> buscaCategoriaPorId(Id categoriaId){
        return [
            SELECT 
                id, 
                Nome__c           
            FROM 
            Categoria__c
            WHERE id =: categoriaId
            LIMIT 1
        ];
    }

    public Categoria__c atualizaInsereCategoria(Id categoriaId, String nome){
        // Instancio meu objeto categoria
        Categoria__c categoria = new Categoria__c();

        // Verifico se o parametro categoriaId não está vindo como nulo (vazio)
        if (categoriaId != null)
        {
            // Se sim, faço uma busca da categoria por ID, atribuindo os valores de retorno para "categoria"
            categoria = buscacategoriaPorId(categoriaId);
        }

        if (nome != '')
        {
            categoria.Nome__c = nome;
        }

        try {
            // Realizo o upsert de "categoria"
            upsert categoria;
        } catch (Exception e) {
            throw new categoriaDAOException('Falha. O(s) seguinte(s) erro(s) foram encontrados: ' + e.getMessage());
        }

        // Retorno a lista do categoria que foi inserido ou atualizado através do método buscaCategoriaPorId()
        return buscaCategoriaPorId(categoria.Id);
    }

    public void deletaCategoria(Id categoriaId){
        // Busco uma categoria por Id
        Categoria__c categoria = buscaCategoriaPorId(categoriaId);

        delete categoria;
    }
    
}
