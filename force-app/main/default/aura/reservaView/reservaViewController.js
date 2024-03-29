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
            { label: 'Título do livro', fieldName: 'LivroTitulo', type: 'text' },
            { label: 'Autor do livro', fieldName: 'LivroAutor', type: 'text' },
            { label: 'Nome do leitor', fieldName: 'LeitorNome', type: 'text' },
            { label: 'Sobrenome do leitor', fieldName: 'LeitorSobrenome', type: 'text' },
            { label: 'Status da reserva', fieldName: 'StatusReserva__c', type: 'text' },
            { label: 'Data da reserva', fieldName: 'DataReserva__c', type: 'date' },
            { type: 'action', typeAttributes: { rowActions: actions } }
        ]);

        // Seto as label para minha v.columns
        component.set('v.livroColumns', [
            { label: 'Título do livro', fieldName: 'Titulo__c', type: 'text' },
            { label: 'Autor do livro', fieldName: 'Autor__c', type: 'text' },
            { label: 'Disponíveis', fieldName: 'QuantidadeDisponivel__c', type: 'text' },
        ]);

        // Seto as label para minha v.columns
        component.set('v.leitorColumns', [
            { label: 'Nome do leitor', fieldName: 'Nome__c', type: 'text' },
            { label: 'Sobrenome do leitor', fieldName: 'Sobrenome__c', type: 'text' },
        ]);

        // Realizo chamada na função searchLivros()
        var searchLivros = component.get('c.searchLivros');

        // Realizo chamada na função searchLeitores()
        var searchLeitores = component.get('c.searchLeitores');

        // Realizo chamada na função searchReservas()
        var searchReservas = component.get('c.searchReservas');


        // Coloco minha chamada na fila
        $A.enqueueAction(searchLeitores);

        // Coloco minha chamada na fila
        $A.enqueueAction(searchLivros);

        // Coloco minha chamada na fila
        $A.enqueueAction(searchReservas);
    },

    // Função disparada toda vez que clico no checkbox padrão do meu datatable
    handleSelectedLivro: function (cmp, evt) {
        // Seto para a variavel selectedRows o que tem no meu parametro selectedRows do datatable
        var selectedRows = evt.getParam('selectedRows');

        // Verifico se a quatidade de linhas selecionadas é maior que 0 (zero)
        if (selectedRows.length > 0) {
            // Setor o valor do Id da primeira linha selecionada para livroId
            cmp.set('v.livroId', selectedRows[0].Id);
        } // Caso não for maior que 0 
        else {
            // Setor valor do meu livroId para nulo
            cmp.set('v.livroId', null);
        }

        // Verifico se a quantidade de linhas selecionadas é maior que 1
        if (selectedRows.length > 1) {
            // Pego na variável de ambiente o meu showToast que está no meu reservaViewHelper
            var toastEvent = $A.get("e.force:showToast");
            // Defino os paramentros de entrada para toastEvent
            toastEvent.setParams({
                "title": "Erro!",
                "message": "Selecione um único livro.",
                "type": "error"
            });

            // Limpo o valor da v.selectedRows e v.livroId
            cmp.set('v.selectedRows', []);
            cmp.set('v.livroId', null);
            // Disparo meu toastEvent
            toastEvent.fire();
        }
    },

    // Função disparada toda vez que clico no checkbox padrão do meu datatable
    handleSelectedLeitor: function (cmp, evt) {
        // Seto para a variavel selectedRows o que tem no meu parametro selectedRows do datatable
        var selectedRows = evt.getParam('selectedRows');

        // Verifico se a quatidade de linhas selecionadas é maior que 0 (zero)
        if (selectedRows.length > 0) {
            // Setor o valor do Id da primeira linha selecionada para leitorId
            cmp.set('v.leitorId', selectedRows[0].Id);
        } // Caso não for maior que 0  
        else {
            // Setor valor do meu leitorId para nulo
            cmp.set('v.leitorId', null);
        }

        // Verifico se a quantidade de linhas selecionadas é maior que 1
        if (selectedRows.length > 1) {
            // Pego na variável de ambiente o meu showToast que está no meu reservaViewHelper
            var toastEvent = $A.get("e.force:showToast");
            // Defino os paramentros de entrada para toastEvent
            toastEvent.setParams({
                "title": "Erro!",
                "message": "Selecione um único leitor.",
                "type": "error"
            });

            // Limpo o valor da v.selectedRows e v.leitorId
            cmp.set('v.selectedRows', []);
            cmp.set('v.leitorId', null);
            // Disparo meu toastEvent
            toastEvent.fire();
        }
    },

    // Função para disparar o searchEmpretimo com uma keyword
    handleClick: function (cmp, evt) {
        // Pego valor do meu enter-search (input definido na tela)
        var keyword = cmp.find('enter-search').get('v.value');

        // Seto esse valor para o meu atribudo keyword da tela
        cmp.set('v.keyword', keyword);

        // Realizo chamada na função searchReservas()
        var searchReservas = cmp.get('c.searchReservas');

        // Coloco minha chamada na fila
        $A.enqueueAction(searchReservas);
    },

    // Função para validar se livroId recebeu um respectivo id
    validateLivroId: function (cmp, evt) {
        // Verifico se v.livroId tem um valor
        if (cmp.get('v.livroId') != null) {
            // Seto para minha variável modal do componente empretimoView como falso
            cmp.set('v.modal', false);
            // Seto para minha variável leitorModal do componente empretimoView como true
            cmp.set('v.leitorModal', true);
            // Limpo selectedRows e keyword para outra possível consulta
            cmp.set('v.selectedRows', []);
            cmp.set('v.keyword', '');
        } else {
            // Pego na variável de ambiente o meu showToast que está no meu reservaViewHelper
            var toastEvent = $A.get("e.force:showToast");
            // Defino os paramentros de entrada para toastEvent
            toastEvent.setParams({
                "title": "Erro!",
                "message": "Selecione um livro para prosseguir.",
                "type": "error"
            });

            // Disparo meu toastEvent
            toastEvent.fire();
        }
    },

    // Função para buscar todos os reservas
    searchReservas: function (component, event, helper) {
        // Realizo a chamada da função buscaReservasPorKeyword na minha ApexControllerClass
        let action = component.get('c.buscaReservasPorKeyword');

        // Defino keyword e status para receber v.keyword e v.selectedFilter
        let keyword = component.get('v.keyword') || '';
        let status = component.get('v.selectedFilter') || '*';

        // Seto os parametros necessários para a chamada
        action.setParams({
            keyword: keyword,
            status: status
        });

        // Realizo o callBack para validar a chamada e pegar a resposta
        action.setCallback(this, function (response) {
            // Defino uma variável para armazenar o estado da chamada
            let state = response.getState();

            // If para verificar se o estado retorna como SUCESSO
            if (state == 'SUCCESS') {
                // Atribuo para rows os valores do retorno
                var rows = response.getReturnValue();

                // Percorro os posições de row
                for (var i = 0; i < rows.length; i++) {
                    // Atribuo para row a posição de rows setadas no "i"
                    var row = rows[i];

                    // Subo uma casa os valores que são relacionais
                    row.LivroTitulo = row.Livro__r.Titulo__c;
                    row.LivroAutor = row.Livro__r.Autor__c;
                    row.LeitorNome = row.Leitor__r.Nome__c;
                    row.LeitorSobrenome = row.Leitor__r.Sobrenome__c;
                }
                // Atribuo a lista de rows na minha lista de reservas do meu componente reservaView
                component.set('v.reservas', rows);
            }
        });

        // Coloco minha chamada na fila
        $A.enqueueAction(action);
    },

    // Função para buscar todos os livros
    searchLivros: function (component, event, helper) {
        // Realizo a chamada da função buscaLivrosPorTituloReserva na minha ApexControllerClass
        let action = component.get('c.buscaLivrosPorTituloReserva');

        // Atribuo para keyword o valor do v.keyword
        let keyword = component.get('v.keyword') || '';

        // Seto os parametros necessarios para o funcionamento do método (action)
        action.setParams({
            titulo: keyword,
        });
        // Realizo o callBack para validar a chamada e pegar a resposta
        action.setCallback(this, function (response) {
            // Defino uma variável para armazenar o estado da chamada
            let state = response.getState();

            // If para verificar se o estado retorna como SUCESSO
            if (state == 'SUCCESS') {

                // Defino uma variável para armazenar a resposta da chamada
                let returnValue = response.getReturnValue();

                // Atribuo a lista da resposta na minha lista de livros do meu componente reservaView
                component.set('v.livros', returnValue);
            }
        });

        // Coloco minha chamada na fila
        $A.enqueueAction(action);
    },

    // Função para buscar todos os leitores
    searchLeitores: function (component, event, helper) {
        // Realizo a chamada da função buscaLeitoresPorNome na minha ApexControllerClass
        let action = component.get('c.buscaLeitoresPorNome');

        // Atribuo para keyword o valor do v.keyword
        let keyword = component.get('v.keyword') || '';

        // Seto os parametros necessarios para o funcionamento do método (action)
        action.setParams({
            nome: keyword,
        });
        // Realizo o callBack para validar a chamada e pegar a resposta
        action.setCallback(this, function (response) {
            // Defino uma variável para armazenar o estado da chamada
            let state = response.getState();

            // Defino uma variável para armazenar a resposta da chamada
            let returnValue = response.getReturnValue();

            // If para verificar se o estado retorna como SUCESSO
            if (state == 'SUCCESS') {
                console.log(returnValue);

                // Atribuo a lista da resposta na minha lista de leitores do meu componente reservaView
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

                // Seto para minha variável detailModal do componente leitorView como verdadeira, abrindo assim meu detailModal
                component.set('v.detailModal', true);

                // Realizo a chamada da função buscaReservaPorId na minha ApexControllerClass
                let actionSearch = component.get('c.buscaReservaPorId');

                // Defino os paramentros de entrada para essa chamada
                actionSearch.setParams({ reservaId: row.Id });

                // Realizo o callBack para validar a chamada e pegar a resposta
                actionSearch.setCallback(this, function (response) {
                    // Defino uma variável para armazenar o estado da chamada
                    let stateSearch = response.getState();

                    // Defino uma variável para armazenar a resposta da chamada
                    let returnValue = response.getReturnValue();

                    // If para verificar se o estado retorna como SUCESSO
                    if (stateSearch == 'SUCCESS') {
                        // Atribuo todos os valores da resposta para as variáves encontradas no meu componente leitorView
                        component.set('v.id', returnValue.Id);
                        component.set('v.livroId', returnValue.Livro__c);
                        component.set('v.leitorId', returnValue.Leitor__c);
                        component.set('v.titulo', returnValue.Livro__r.Titulo__c);
                        component.set('v.autor', returnValue.Livro__r.Autor__c);
                        component.set('v.nome', returnValue.Leitor__r.Nome__c);
                        component.set('v.sobrenome', returnValue.Leitor__r.Sobrenome__c);
                        component.set('v.status', returnValue.StatusReserva__c);
                        component.set('v.dataReserva', returnValue.DataReserva__c);
                    }
                });

                // Coloco minha chamada na fila
                $A.enqueueAction(actionSearch);

                // Finalizo a condição do show_details
                break;

            // Caso a entrada for delete, então executo tudo dessa case
            case 'delete':

                // Realizo a chamada da função deletaReserva na minha ApexControllerClass
                let actionDelete = component.get('c.deletaReserva');

                // Defino os paramentros de entrada para essa chamada
                actionDelete.setParams({ reservaId: row.Id });

                // Pego na variável de ambiente o meu showToast que está no meu reservaViewHelper
                var toastEvent = $A.get("e.force:showToast");

                // Realizo o callBack para validar a chamada e pegar a resposta
                actionDelete.setCallback(this, function (response) {
                    // Defino uma variável para armazenar o estado da chamada
                    let stateDelete = response.getState();

                    // If para verificar se o estado retorna como SUCESSO
                    if (stateDelete == 'SUCCESS') {

                        // Realizo chamada na função init() para atualizar os dados da tela
                        var init = component.get('c.init');

                        // Defino os paramentros de entrada para toastEvent
                        toastEvent.setParams({
                            "title": "Successo!",
                            "message": "Reserva deletada com sucesso.",
                            "type": "success"
                        });

                        // Disparo meu toastEvent
                        toastEvent.fire();

                        // Coloco minha função init() na fila
                        $A.enqueueAction(init);
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

    // Função para atualizar ou inserir um reserva
    upsertReserva: function (component, event, helper) {

        // Realizo a chamada do atualizaInsereReserva da minha ApexControllerClass
        let action = component.get('c.atualizaInsereReserva');


        // Pego na variável de ambiente o meu showToast
        var toastEvent = $A.get("e.force:showToast");

        // Verifico se leitorId possui um valor
        if (component.get('v.leitorId') == null) {

            // Pego na variável de ambiente o meu showToast que está no meu reservaViewHelper
            var toastEvent = $A.get("e.force:showToast");
            // Defino os paramentros de entrada para toastEvent
            toastEvent.setParams({
                "title": "Erro!",
                "message": "Selecione um leitor para salvar.",
                "type": "error"
            });

            // Disparo meu toastEvent
            toastEvent.fire();
        }

        // Seto os parametros necessários para a chamada
        action.setParams({
            reservaId: component.get("v.id"),
            livroId: component.get("v.livroId"),
            leitorId: component.get("v.leitorId"),
            status: component.get("v.status")
        });

        // Realizo um callback para validar e pegar a resposta do meu back-end
        action.setCallback(this, function (response) {
            // Atribuo o estado da resposta na variavel state
            let state = response.getState();


            // Verifico de a resposta é SUCCESS
            if (state == 'SUCCESS') {
                // Realizo a chamada na função searchReservas() para atualizar a lista de leitores
                var searchReservas = component.get('c.searchReservas');

                // Realizo a chamada na função searchLivros() para atualizar a lista de leitores
                var searchLivros = component.get('c.searchLivros');

                // Realizo a chamada na função searchLeitores() para atualizar a lista de leitores
                var searchLeitores = component.get('c.searchLeitores');

                // Atribuo como false a minha variavel modal, para esconder meu modal
                component.set('v.leitorModal', false);
                component.set('v.detailModal', false);

                // Verifico se o Id é nulo
                if (component.get("v.id") == null) {
                    // Defino os paramentros de entrada no meu toastEvent
                    toastEvent.setParams({
                        "title": "Successo!",
                        "message": "Reserva criada com sucesso.",
                        "type": "success"
                    });

                }
                // Caso Id possuir um valor
                else {
                    // Defino os paramentros de entrada no meu toastEvent
                    toastEvent.setParams({
                        "title": "Successo!",
                        "message": "Reserva atualizada com sucesso.",
                        "type": "success"
                    });
                }

                // Disparo o toastEvent
                toastEvent.fire();

                // Coloco na fila minha função searchLeitores()
                $A.enqueueAction(searchLeitores);
                // Coloco na fila minha função searchLivros()
                $A.enqueueAction(searchLivros);
                // Coloco na fila minha função searchReservas()
                $A.enqueueAction(searchReservas);
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
        component.set('v.keyword', '');
        // Coloco na fila minha chamada action
        $A.enqueueAction(action);
    },

    // Função para abrir modal com as variáveis limpas
    showModal: function (component, event, helper) {
        // Limpo minhas variáveis do reservaView
        component.set('v.id', null);
        component.set('v.leitorId', null);
        component.set('v.livroId', null);
        component.set('v.nome', '');
        component.set('v.sobrenome', '');
        component.set('v.titulo', '');
        component.set('v.autor', '');
        component.set('v.status', '');
        component.set('v.dataReserva', null);
        component.set('v.keyword', '');
        component.set('v.selectedRows', []);

        // Seto para minha variável modal do componente reservaView como verdadeira, abrindo assim meu modal
        component.set('v.modal', true);
    },

    // Função para voltar modal de buscar livro com as variáveis limpas
    backModal: function (component, event, helper) {
        // Limpo minhas variáveis do reservaView
        component.set('v.id', null);
        component.set('v.leitorId', null);
        component.set('v.livroId', null);
        component.set('v.nome', '');
        component.set('v.sobrenome', '');
        component.set('v.titulo', '');
        component.set('v.autor', '');
        component.set('v.status', '');
        component.set('v.dataReserva', null);
        component.set('v.keyword', '');
        component.set('v.selectedRows', []);

        // Seto para minha variável modal do componente reservaView como verdadeira, abrindo assim meu modal
        component.set('v.modal', true);

        // Seto para minha variável detailModal do componente reservaView como falsa
        component.set('v.leitorModal', false);


        // Realizo chamada na função searchLivros()
        var searchLivros = component.get('c.searchLivros');

        // Realizo chamada na função searchLeitores()
        var searchLeitores = component.get('c.searchLeitores');

        // Realizo chamada na função searchReservas()
        var searchReservas = component.get('c.searchReservas');


        // Coloco minha chamada na fila
        $A.enqueueAction(searchLeitores);

        // Coloco minha chamada na fila
        $A.enqueueAction(searchLivros);

        // Coloco minha chamada na fila
        $A.enqueueAction(searchReservas);
    },

    // Função para fechar detailModal
    closeModal: function (component, event, helper) {
        // Limpo minhas variáveis do reservaView
        component.set('v.id', null);
        component.set('v.leitorId', null);
        component.set('v.livroId', null);
        component.set('v.nome', '');
        component.set('v.sobrenome', '');
        component.set('v.titulo', '');
        component.set('v.autor', '');
        component.set('v.status', '');
        component.set('v.dataReserva', null);
        component.set('v.keyword', '');
        component.set('v.selectedRows', []);

        // Seto para minha variável detailModal do componente reservaView como falsa
        component.set('v.modal', false);
        component.set('v.leitorModal', false);
        component.set('v.detailModal', false);

        // Realizo chamada na função searchLivros()
        var searchLivros = component.get('c.searchLivros');

        // Realizo chamada na função searchLeitores()
        var searchLeitores = component.get('c.searchLeitores');

        // Realizo chamada na função searchReservas()
        var searchReservas = component.get('c.searchReservas');


        // Coloco minha chamada na fila
        $A.enqueueAction(searchLeitores);

        // Coloco minha chamada na fila
        $A.enqueueAction(searchLivros);

        // Coloco minha chamada na fila
        $A.enqueueAction(searchReservas);
    }

})
