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

    public Periodico__c atualizaInserePeriodico(Id periodicoId, String nome) {
        // Instancio meu objeto periodico
        Periodico__c periodico = new Periodico__c();

        // Verifico se o parametro periodicoId não está vindo como nulo (vazio)
        if (periodicoId != null)
            periodico = buscaPeriodicoPorId(periodicoId);

        if (nome != '')
            periodico.Nome__c = nome;

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
