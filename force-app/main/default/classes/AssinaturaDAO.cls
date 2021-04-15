public with sharing class AssinaturaDAO {
    public AssinaturaDAO() {

    }

    public List<Assinatura__c> buscaAssinaturas() {

        return [
            SELECT 
                id, // Buscar relacionamentos
                Leitor__c,
                Periodico__c,
                TipoAssinatura__c
            FROM 
                Assinatura__c
            ORDER BY Nome__c DESC
        ];
    }

    public Assinatura__c buscaAssinaturaPorId(Id assinaturaId) {

        return [
            SELECT 
                id, // Buscar relacionamentos
                Leitor__c,
                Periodico__c,
                TipoAssinatura__c
            FROM
                Assinatura__c
            WHERE id = :assinaturaId
        ];
    }

    public Assinatura__c atualizaInsereAssinatura(Id assinaturaId, Id leitorId, Id periodicoId) {

        Assinatura__c assinatura = new Assinatura__c();

        // Verifico se o parametro assinaturaId não está vindo como nulo (vazio)
        if (assinaturaId != null)
        {
            // Faço uma busca do assinatura por ID, atribuindo os valores de retorno para "assinatura"
            assinatura = buscaAssinaturaPorId(assinaturaId);
        }
        else 
        {
            // Verifico se o parametro livroId não está vindo como nulo (vazio)
            if (leitorId != null) 
            {
                // Atribuo livroId para o Livro__c de assinatura
                assinatura.Leitor__c = leitorId;
            }
            // Verifico se o parametro livroId não está vindo como nulo (vazio)
            if (periodicoId != null) 
            {
                // Atribuo leitorId para o Leitor__c de assinatura
                assinatura.Periodico__c = periodicoId;
            }
        }

        try {
            // Realizo o upsert de "assinatura"
            upsert assinatura;
        } catch (DmlException e) {
            // Realizo um throw, instaciando um Exception customizado e atribuindo uma mensagem para ele
            throw new AssinaturaDAOException('Entrar em contato com o suporte');
        }

        return buscaAssinaturaPorId(assinatura.Id);
    }

    public void deletaAssinatura() {

        Assinatura__c assinatura = buscaAssinaturaPorId(assinaturaId);

        delete assinatura;
    }

    public class AssinaturaDAOException extends Exception {}
}