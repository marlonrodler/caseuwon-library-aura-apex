public with sharing class PublicacaoDAO {
    public PublicacaoDAO() {

    }

    // Defino método para retornar uma Publicacao que tenha id igual a publicacaoId
    public List<Publicacao__c> buscaPublicacaoPorId(Id publicacaoId){
        return [
            SELECT 
                id, 
                Titulo__c,
                Resumo__c,
                Link__c
            FROM 
            Publicacao__c
            WHERE id =: publicacaoId
            LIMIT 1
        ];
    }

    public Publicacao__c atualizaInserePublicacao(Id publicacaoId, String titulo, String resumo, String link){
        // Instancio meu objeto Publicacao
        Publicacao__c publicacao = new Publicacao__c();

        // Verifico se o parametro publicacaoId não está vindo como nulo (vazio)
        if (publicacaoId != null)
        {
            // Se sim, faço uma busca da publicacao por ID, atribuindo os valores de retorno para "publicacao"
            publicacao = buscaPublicacaoPorId(publicacaoId);
        }

        if (titulo != '')
        {
            publicacao.Titulo__c = titulo;
        }

        if (resumo != '')
        {
            publicacao.Resumo__c = resumo;
        }

        if (link != '')
        {
            publicacao.Link__c = link;
        }

        try {
            // Realizo o upsert de "publicacao"
            upsert publicacao;
        } catch (Exception e) {
            throw new PublicacaoDAOException('Falha. O(s) seguinte(s) erro(s) foram encontrados: ' + e.getMessage());
        }

        // Retorno a lista do Leitor que foi inserido ou atualizado através do método buscaPublicacaoPorId()
        return buscaPublicacaoPorId(publicacao.Id);
    }

    public void deletaPublicacao(Id publicacaoId){
        // Busco uma publicacao por Id
        Publicacao__c publicacao = buscaPublicacaoPorId(publicacaoId);

        delete publicacao;
    }

    // Defino um método PublicacaoDAOException que puxa as especificidades da classe Exception 
    public class PublicacaoDAOException extends Exception {}
}
