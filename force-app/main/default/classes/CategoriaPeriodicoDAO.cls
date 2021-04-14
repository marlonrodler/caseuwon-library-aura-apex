public with sharing class CategoriaPeriodicoDAO {
    public CategoriaPeriodicoDAO() {

    }

    // Defino método para retornar uma Categoria que tenha id igual a categoria_periodicoId
    public List<CategoriaPeriodico__c> buscaCetgoriaPeriodicoPorId(Id categoria_periodicoId){
        return [
            SELECT 
                id, 
                Categoria__c,
                Periodico__c           
            FROM 
            CategoriaPeriodico__c
            WHERE id =: categoria_periodicoId
            LIMIT 1
        ];
    }

    public CategoriaPeriodico__c atualizaInsereCategoria(Id categoria_periodicoId, Id categoria, Id periodico){
        // Instancio meu objeto categoria
        CategoriaPeriodico__c categoria_periodico = new CategoriaPeriodico__c();

        // Verifico se o parametro categoria_periodicoId não está vindo como nulo (vazio)
        if (categoria_periodicoId != null)
        {
            // Se sim, faço uma busca da categoria por ID, atribuindo os valores de retorno para "categoria"
            categoria_periodico = buscaCetgoriaPeriodicoPorId(categoria_periodicoId);
        }

        if (categoria != null)
        {
            categoria_periodico.Categoria__c = categoria;
        }

        if (periodico != null)
        {
            categoria_periodico.Categoria__c = periodico;
        }

        try {
            // Realizo o upsert de "categoria"
            upsert categoria_periodico;
        } catch (Exception e) {
            throw new categoriaDAOException('Falha. O(s) seguinte(s) erro(s) foram encontrados: ' + e.getMessage());
        }

        return buscaCetgoriaPeriodicoPorId(categoria_periodico.Id);
    }

    public void deletaCategoria(Id categoria_periodicoId){
        // Busco uma categoria por Id
        CategoriaPeriodico__c categoria_periodico = buscaCetgoriaPeriodicoPorId(categoria_periodicoId);

        delete categoria_periodico;
    }
}
