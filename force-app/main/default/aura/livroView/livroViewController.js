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
            { label: 'Código do livro', fieldName: 'Codigo__c', type: 'text' },
            { label: 'Título do livro', fieldName: 'Titulo__c', type: 'text' },
            { label: 'Autor do livro', fieldName: 'Autor__c', type: 'text' },
            { label: 'Quantidade', fieldName: 'Quantidade__c', type: 'number' },
            { label: 'Categoria', fieldName: 'Categoria__c', type: 'text' },
            { label: 'Quantidade Disponível', fieldName: 'QuantidadeDisponivel__c', type: 'number' },
            { label: 'Quantidade Emprestada', fieldName: 'QuantidadeEmprestada__c', type: 'number' },
            { type: 'action', typeAttributes: { rowActions: actions } }
        ]);

        // Realizo chamada na função searchLivros()
        var searchLivros = component.get('c.searchLivros');

        // Coloco minha chamada na fila
        $A.enqueueAction(searchLivros);
    },

    // Função para buscar todos os livros
    searchLivros: function (component, event, helper) {
        // Realizo a chamada da função buscaLivros na minha ApexControllerClass
        let action = component.get('c.buscaLivros');

        // Realizo o callBack para validar a chamada e pegar a resposta
        action.setCallback(this, function (response) {
            // Defino uma variável para armazenar o estado da chamada
            let state = response.getState();

            // Defino uma variável para armazenar a resposta da chamada
            let returnValue = response.getReturnValue();

            // If para verificar se o estado retorna como SUCESSO
            if (state == 'SUCCESS') {

                // Atribuo a lista da resposta na minha lista de livros do meu componente livroView
                component.set('v.livros', returnValue);
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

                // Seto para minha variável modal do componente livroView como verdadeira, abrindo assim meu modal
                component.set('v.modal', true);

                // Realizo a chamada da função buscaLivroPorId na minha ApexControllerClass
                let actionSearch = component.get('c.buscaLivroPorId');

                // Defino os paramentros de entrada para essa chamada
                actionSearch.setParams({ livroId: row.Id });

                // Realizo o callBack para validar a chamada e pegar a resposta
                actionSearch.setCallback(this, function (response) {
                    // Defino uma variável para armazenar o estado da chamada
                    let stateSearch = response.getState();

                    // If para verificar se o estado retorna como SUCESSO
                    if (stateSearch == 'SUCCESS') {

                        // Defino uma variável para armazenar a resposta da chamada
                        let returnValue = response.getReturnValue();

                        // Atribuo todos os valores da resposta para as variáves encontradas no meu componente livroView
                        component.set('v.id', returnValue.Id);
                        component.set('v.codigo', returnValue.Codigo__c);
                        component.set('v.titulo', returnValue.Titulo__c);
                        component.set('v.autor', returnValue.Autor__c);
                        component.set('v.categoria', returnValue.Categoria__c);
                        component.set('v.quantidade', returnValue.Quantidade__c);
                        component.set('v.quantidadeDisponivel', returnValue.QuantidadeDisponivel__c);
                        component.set('v.quantidadeEmprestada', returnValue.QuantidadeEmprestada__c);
                    }
                });

                // Coloco minha chamada na fila
                $A.enqueueAction(actionSearch);

                // Finalizo a condição do show_details
                break;

            // Caso a entrada for delete, então executo tudo dessa case
            case 'delete':

                // Realizo a chamada da função deletaLivro na minha ApexControllerClass
                let actionDelete = component.get('c.deletaLivro');

                // Defino os paramentros de entrada para essa chamada
                actionDelete.setParams({ livroId: row.Id });

                // Pego na variável de ambiente o meu showToast que está no meu livroViewHelper
                var toastEvent = $A.get("e.force:showToast");

                // Realizo o callBack para validar a chamada e pegar a resposta
                actionDelete.setCallback(this, function (response) {
                    // Defino uma variável para armazenar o estado da chamada
                    let stateDelete = response.getState();

                    // If para verificar se o estado retorna como SUCESSO
                    if (stateDelete == 'SUCCESS') {

                        // Realizo chamada na função searchLivros() para atualizar os dados da tela
                        var searchLivros = component.get('c.searchLivros');

                        // Defino os paramentros de entrada para toastEvent
                        toastEvent.setParams({
                            "title": "Successo!",
                            "message": "Livro deletado com sucesso.",
                            "type": "success"
                        });

                        // Disparo meu toastEvent
                        toastEvent.fire();

                        // Coloco minha função searchLivros() na fila
                        $A.enqueueAction(searchLivros);
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

    // Função para atualizar ou inserir um livro
    upsertLivro: function (component, event, helper) {
        // Realizo a chamada do atualizaInsereLivro da minha ApexControllerClass
        let action = component.get('c.atualizaInsereLivro');

        // Seto os parametros necessários para a chamada
        action.setParams({
            livroId: component.get("v.id"),
            codigo: component.get("v.codigo"),
            titulo: component.get("v.titulo"),
            autor: component.get("v.autor"),
            categoria: component.get("v.categoria"),
            quantidade: component.get("v.quantidade")
        });

        // Realizo um callback para validar e pegar a resposta do meu back-end
        action.setCallback(this, function (response) {
            // Atribuo o estado da resposta na variavel state
            let state = response.getState();

            // Pego na variável de ambiente o meu showToast que está no meu livroViewHelper
            var toastEvent = $A.get("e.force:showToast");

            // Verifico de a resposta é SUCCESS
            if (state == 'SUCCESS') {
                // Realizo a chamada na função searchLivros() para atualizar a lista de livros
                var searchLivros = component.get('c.searchLivros');

                // Atribuo como false a minha variavel modal, para esconder meu modal
                component.set('v.modal', false);

                // Verifico se o Id é nulo, se sim, retorno um toastEvent diferente
                if (component.get("v.id") == null) {
                    // Defino os paramentros de entrada no meu toastEvent
                    toastEvent.setParams({
                        "title": "Successo!",
                        "message": "Livro criado com sucesso.",
                        "type": "success"
                    });

                }
                // Caso Id possuir um valor
                else {
                    // Defino os paramentros de entrada no meu toastEvent
                    toastEvent.setParams({
                        "title": "Successo!",
                        "message": "Livro atualizado com sucesso.",
                        "type": "success"
                    });
                }

                // Disparo o toastEvent
                toastEvent.fire();

                // Coloco na fila minha função searchLivros()
                $A.enqueueAction(searchLivros);
            }
            // Caso state retorne como diferente de SUCESSO
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
        // Limpo minhas variáveis do livroView
        component.set('v.id', null);
        component.set('v.codigo', '');
        component.set('v.titulo', '');
        component.set('v.autor', '');
        component.set('v.quantidade', null);
        component.set('v.quantidadeDisponivel', null);
        component.set('v.quantidadeEmprestada', null);
        component.set('v.categoria', '');

        // Seto para minha variável modal do componente livroView como verdadeira, abrindo assim meu modal
        component.set('v.modal', true);
    },

    // Função para fechar modal
    closeModal: function (component, event, helper) {
        // Limpo minhas variáveis do livroView
        component.set('v.id', null);
        component.set('v.codigo', '');
        component.set('v.titulo', '');
        component.set('v.autor', '');
        component.set('v.quantidade', null);
        component.set('v.quantidadeDisponivel', null);
        component.set('v.quantidadeEmprestada', null);
        component.set('v.categoria', '');

        // Seto para minha variável modal do componente livroView como falsa, fechando assim meu modal
        component.set('v.modal', false);
    }

})
