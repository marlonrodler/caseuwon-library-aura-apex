public with sharing class AssinaturaController {
    public AssinaturaController() {

    }

    @AuraEnabled
    public static List<Assinatura__c> buscaAssinaturas() {
        try {
            AssinaturaDAO dao = new AssinaturaDAO();

            return dao.buscaAssinaturas();

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
