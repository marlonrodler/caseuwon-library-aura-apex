({
    parseReturnValue : function (values) {

        return values.map((row) => {
            return {
                NomeLeitor__c: row.Leitor__r.Nome__c + ' ' + row.Leitor__r.Sobrenome__c,
                NomePeriodico__c: row.Periodico__r.Nome__c,
                TipoAssinatura__c: row.TipoAssinatura__c,
                DataAssinatura__c: row.DataAssinatura__c
            };
        });
    }
})
