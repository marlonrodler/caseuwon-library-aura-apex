public with sharing class AssinaturaDAO {
    public AssinaturaDAO() {

    }

    public List<Assinatura__c> buscaAssinaturas() {

        return [
            SELECT 
                id, // Buscar relacionamentos
                Leitor__c,
                Leitor__r.Nome__c,
                Leitor__r.Sobrenome__c,
                Periodico__r.Nome__c,
                DataAssinatura__c,
                TipoAssinatura__c
            FROM 
                Assinatura__c
            ORDER BY Name DESC
        ];
    }

    public Assinatura__c buscaAssinaturaPorId(Id assinaturaId) {

        return [
            SELECT 
                id, // Buscar relacionamentos
                Leitor__c,
                Periodico__c,
                DataAssinatura__c,
                TipoAssinatura__c
            FROM
                Assinatura__c
            WHERE id = :assinaturaId
        ];
    }

    public List<Assinatura__c> buscaAssinaturasPorKeyword(String keyword, String status) 
    {

        // Concateno meu keyword com '%', ficando '%keyword%'
        keyword = '%'+keyword+'%';

        // Valido qual o valor que está vindo em status
        if (status == '*') 
        {
            status = '%%';
        }

        return [
            SELECT 
                id,
                Periodico__c,
                Leitor__c,
                Periodico__r.Nome__c,
                Leitor__r.Nome__c,
                Leitor__r.Sobrenome__c,
                DataAssinatura__c,
                TipoAssinatura__c
            FROM 
                Assinatura__c
            WHERE 
                Periodico__r.Nome__c LIKE :keyword
            ORDER BY Name DESC
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
                // Atribuo periodicoId para o Periodico__c de assinatura
                assinatura.Periodico__c = periodicoId;
            }
        }

        try {
            // Realizo o upsert de "assinatura"
            upsert assinatura;
        } catch (DmlException e) {
            // Realizo um throw, instaciando um Exception customizado e atribuindo uma mensagem para ele
            throw new AssinaturaDAOException('Entrar em contato com o suporte: ' + e);
        }

        return buscaAssinaturaPorId(assinatura.Id);
    }

    public void deletaAssinatura(Id assinaturaId) {

        Assinatura__c assinatura = buscaAssinaturaPorId(assinaturaId);

        delete assinatura;
    }

    public class AssinaturaDAOException extends Exception {}
}
