({
    // Função para iniciar meu componente com com a variável columns preenchida
    init: function (component, event, helper) {
        // Defino actions como array contendo as labels de ação
        var actions = [
            { label: 'Mostrar Detalhes', name: 'show_details' },
            { label: 'Deletar', name: 'delete' }
        ];

        // Seto as label para minha v.columns
        component.set('v.columns', [
            { label: 'Nome do leitor', fieldName: 'Nome__c', type: 'text' },
            { label: 'Sobrenome do leitor', fieldName: 'Sobrenome__c', type: 'text' },
            { label: 'Idade do leitor', fieldName: 'Idade__c', type: 'number' },
            { label: 'RG do leitor', fieldName: 'RG__c', type: 'text' },
            { type: 'action', typeAttributes: { rowActions: actions } }
        ]);

        // Realizo chamada na função searchLeitores()
        var searchLeitores = component.get('c.searchLeitores');

        // Coloco minha chamada na fila
        $A.enqueueAction(searchLeitores);
    },

    // Função para buscar todos os leitores
    searchLeitores: function (component, event, helper) {
        // Realizo a chamada da função buscaLeitores na minha ApexControllerClass
        let action = component.get('c.buscaLeitores');

        // Realizo o callBack para validar a chamada e pegar a resposta
        action.setCallback(this, function (response) {
            // Defino uma variável para armazenar o estado da chamada
            let state = response.getState();

            // Defino uma variável para armazenar a resposta da chamada
            let returnValue = response.getReturnValue();

            // If para verificar se o estado retorna como SUCESSO
            if (state == 'SUCCESS') {

                // Atribuo a lista da resposta na minha lista de leitores do meu componente leitorView
                component.set('v.leitores', returnValue);
            }
        });

        // Coloco minha chamada na fila
        $A.enqueueAction(action);
    },

    // Função para definir as ações
    handleRowAction: function (component, event, helper) {
        // Pego a ação do meu event e atribuo para action
        var action = event.getParam('action');

        // Pego a linha do meu event e atribuo para row
        var row = event.getParam('row');

        // Defino a entrada do meu switch o nome da ação
        switch (action.name) {
            // Caso a entrada for show_detail, então executo tudo dessa case
            case 'show_details':

                // Seto para minha variável modal do componente leitorView como verdadeira, abrindo assim meu modal
                component.set('v.modal', true);

                // Realizo a chamada da função buscaLeitorPorId na minha ApexControllerClass
                let actionSearch = component.get('c.buscaLeitorPorId');

                // Defino os paramentros de entrada para essa chamada
                actionSearch.setParams({ leitorId: row.Id });

                // Realizo o callBack para validar a chamada e pegar a resposta
                actionSearch.setCallback(this, function (response) {
                    // Defino uma variável para armazenar o estado da chamada
                    let stateSearch = response.getState();

                    // If para verificar se o estado retorna como SUCESSO
                    if (stateSearch == 'SUCCESS') {
                        // Defino uma variável para armazenar a resposta da chamada
                        let returnValue = response.getReturnValue();

                        // Atribuo todos os valores da resposta para as variáves encontradas no meu componente leitorView
                        component.set('v.id', returnValue.Id);
                        component.set('v.nome', returnValue.Nome__c);
                        component.set('v.sobrenome', returnValue.Sobrenome__c);
                        component.set('v.idade', returnValue.Idade__c);
                        component.set('v.rg', returnValue.RG__c);
                    }
                });

                // Coloco minha chamada na fila
                $A.enqueueAction(actionSearch);

                // Finalizo a condição do show_details
                break;

            // Caso a entrada for delete, então executo tudo dessa case
            case 'delete':

                // Realizo a chamada da função deletaLeitor na minha ApexControllerClass
                let actionDelete = component.get('c.deletaLeitor');

                // Defino os paramentros de entrada para essa chamada
                actionDelete.setParams({ leitorId: row.Id });

                // Pego na variável de ambiente o meu showToast
                var toastEvent = $A.get("e.force:showToast");

                // Realizo o callBack para validar a chamada e pegar a resposta
                actionDelete.setCallback(this, function (response) {
                    // Defino uma variável para armazenar o estado da chamada
                    let stateDelete = response.getState();

                    // If para verificar se o estado retorna como SUCESSO
                    if (stateDelete == 'SUCCESS') {

                        // Realizo chamada na função searchLeitores() para atualizar os dados da tela
                        var searchLeitores = component.get('c.searchLeitores');

                        // Defino os paramentros de entrada para toastEvent
                        toastEvent.setParams({
                            "title": "Successo!",
                            "message": "Leitor deletado com sucesso.",
                            "type": "success"
                        });

                        // Disparo meu toastEvent
                        toastEvent.fire();

                        // Coloco minha função searchLeitores() na fila
                        $A.enqueueAction(searchLeitores);
                    }
                    // Caso stateDelete retorne como diferente de SUCESSO
                    else {
                        // Pego o erro da minha resposta
                        let errors = response.getError();

                        // Atribuo uma mensagem de erro padrão
                        let message = 'Erro desconhecido';

                        // Valido se minha variável erro possui algum valor
                        if (errors && Array.isArray(errors) && errors.length > 0) {

                            // Sobreescrevo minha mensagem padrão com o que está vindo de resposta
                            message = errors[0].message;
                        }

                        // Defino os paramentros de entrada para toastEvent
                        toastEvent.setParams({
                            "title": "Erro!",
                            "message": message,
                            "type": "error"
                        });

                        // Disparo meu toastEvent
                        toastEvent.fire();
                    }
                });

                // Coloco minha função actionDelete() na fila
                $A.enqueueAction(actionDelete);

                // Finalizo a condição do delete
                break;
        }
    },

    // Função para atualizar ou inserir um leitor
    upsertLeitor: function (component, event, helper) {

        // Realizo a chamada do atualizaInsereLeitor da minha ApexControllerClass
        let action = component.get('c.atualizaInsereLeitor');

        // Seto os parametros necessários para a chamada
        action.setParams({
            leitorId: component.get("v.id"),
            nome: component.get("v.nome"),
            sobrenome: component.get("v.sobrenome"),
            rg: component.get("v.rg"),
            idade: component.get("v.idade")
        });

        // Realizo um callback para validar e pegar a resposta do meu back-end
        action.setCallback(this, function (response) {
            // Atribuo o estado da resposta na variavel state
            let state = response.getState();

            // Pego na variável de ambiente o meu showToast
            var toastEvent = $A.get("e.force:showToast");

            // Verifico de a resposta é SUCCESS
            if (state == 'SUCCESS') {
                // Realizo a chamada na função searchLeitores() para atualizar a lista de leitores
                var searchLeitores = component.get('c.searchLeitores');

                // Atribuo como false a minha variavel modal, para esconder meu modal
                component.set('v.modal', false);

                // Verifico se o Id é nulo, se sim, retorno um toastEvent diferente
                if (component.get("v.id") == null) {
                    // Defino os paramentros de entrada no meu toastEvent
                    toastEvent.setParams({
                        "title": "Successo!",
                        "message": "Leitor criado com sucesso.",
                        "type": "success"
                    });

                }
                // Caso Id possuir um valor
                else {
                    // Defino os paramentros de entrada no meu toastEvent
                    toastEvent.setParams({
                        "title": "Successo!",
                        "message": "Leitor atualizado com sucesso.",
                        "type": "success"
                    });
                }

                // Disparo o toastEvent
                toastEvent.fire();

                // Coloco na fila minha função searchLeitores()
                $A.enqueueAction(searchLeitores);
            }// Caso state retorne como diferente de SUCESSO
            else {
                // Pego o erro da minha resposta
                let errors = response.getError();

                // Atribuo uma mensagem de erro padrão
                let message = 'Erro desconhecido';

                // Valido se minha variável erro possui algum valor
                if (errors && Array.isArray(errors) && errors.length > 0) {

                    // Sobreescrevo minha mensagem padrão com o que está vindo de resposta
                    message = errors[0].message;
                }

                // Defino os paramentros de entrada para toastEvent
                toastEvent.setParams({
                    "title": "Erro!",
                    "message": message,
                    "type": "error"
                });

                // Disparo meu toastEvent
                toastEvent.fire();
            }
        });
        // Coloco na fila minha chamada action
        $A.enqueueAction(action);
    },

    // Função para abrir modal com as variáveis limpas
    showModal: function (component, event, helper) {
        // Limpo meus atributos do leitorView
        component.set('v.id', null);
        component.set('v.nome', '');
        component.set('v.sobrenome', '');
        component.set('v.idade', null);
        component.set('v.rg', '');

        // Seto para minha variável modal do componente leitorView como verdadeira, abrindo assim meu modal
        component.set('v.modal', true);
    },

    // Função para fechar modal
    closeModal: function (component, event, helper) {
        // Limpo minhas atributos do leitorView
        component.set('v.id', null);
        component.set('v.nome', '');
        component.set('v.sobrenome', '');
        component.set('v.idade', null);
        component.set('v.rg', '');

        // Seto para minha variável modal do componente leitorView como falsa, fechando assim meu modal
        component.set('v.modal', false);
    }

})
