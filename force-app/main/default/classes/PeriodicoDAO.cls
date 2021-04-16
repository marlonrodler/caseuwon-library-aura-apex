public with sharing class PeriodicoDAO {
    public PeriodicoDAO() {

    }

    public List<Periodico__c> buscaPeriodicos() {

        return [
            SELECT 
                id, 
                Nome__c,
                Categoria__c
            FROM 
                Periodico__c
            ORDER BY Nome__c DESC
        ];
    }

    public Periodico__c buscaPeriodicoPorId(Id periodicoId) {

        return [
            SELECT 
                id, 
                Nome__c,
                Categoria__c
            FROM 
                Periodico__c
            WHERE id = :periodicoId
        ];
    }

    // Defino método para retornar uma lista periodico pelo seu Nome através do parametro nome
    public List<Periodico__c> buscaPeriodicosPorNome(String nome) 
    {
        nome = '%'+nome+'%';
        return [
            SELECT 
                id, 
                Nome__c,
                Categoria__c
            FROM 
                Periodico__c
            WHERE Nome__c = :nome
        ];
    }

    public Periodico__c atualizaInserePeriodico(Id periodicoId, String nome, String categoria) {
        // Instancio meu objeto periodico
        Periodico__c periodico = new Periodico__c();

        // Verifico se o parametro periodicoId não está vindo como nulo (vazio)
        if (periodicoId != null)
            periodico = buscaPeriodicoPorId(periodicoId);

        if (nome != '')
            periodico.Nome__c = nome;
        
        if (categoria != '')
            periodico.Categoria__c = categoria;

        try {
            upsert periodico;
        } catch (Exception e) {
            throw new periodicoDAOException('Falha. O(s) seguinte(s) erro(s) foram encontrados: ' + e.getMessage());
        }

        return buscaPeriodicoPorId(periodico.Id);
    }

    public void deletaPeriodico(Id periodoId) {

        Periodico__c periodo = buscaPeriodicoPorId(periodoId);

        delete periodo;
    }

    public class PeriodicoDAOException extends Exception {}
}
