public with sharing class ReservaDAO 
{
    public ReservaDAO() 
    {

    }

    // Defino método para retornar uma lista de Reservas
    public List<Reserva__c> buscaReservas() 
    {
        return [
            SELECT 
                id,
                Livro__c,
                Leitor__c,
                Livro__r.Titulo__c,
                Livro__r.Autor__c,
                Leitor__r.Nome__c,
                Leitor__r.Sobrenome__c,
                StatusReserva__c,
                DataReserva__c
            FROM 
                Reserva__c
            ORDER BY Name DESC
        ];
    }
    
    // Defino método para retornar uma lista de Reservas relacionadas com os parametros que defino
    public List<Reserva__c> buscaReservasPorKeyword(String keyword, String status) 
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
                Livro__c,
                Leitor__c,
                Livro__r.Titulo__c,
                Livro__r.Autor__c,
                Leitor__r.Nome__c,
                Leitor__r.Sobrenome__c,
                StatusReserva__c,
                DataReserva__c
            FROM 
                Reserva__c
            WHERE 
                (
                    Livro__r.Titulo__c LIKE :keyword OR 
                    Leitor__r.Nome__c LIKE :keyword OR 
                    Leitor__r.Sobrenome__c LIKE :keyword
                )
                AND
                (
                    StatusReserva__c LIKE :status 
                )
            ORDER BY Name DESC
        ];
    }

    // Defino método para retornar um Reservas que tenha id igual a reservaId
    public Reserva__c buscaReservaPorId(Id reservaId) 
    {
        return [
            SELECT 
                id, 
                Livro__c,
                Leitor__c,
                Livro__r.Titulo__c,
                Livro__r.Autor__c,
                Leitor__r.Nome__c,
                Leitor__r.Sobrenome__c,
                StatusReserva__c,
                DataReserva__c
            FROM 
                Reserva__c
            WHERE id =: reservaId
            LIMIT 1
        ];
    }
    
    // Defino método para retornar uma lista de Reservas que tenha Livro__c igual a livroId
    public List<Reserva__c> buscaReservaPorLivro(Id livroId) 
    {
        return [
            SELECT 
                id, 
                Livro__c,
                Leitor__c,
                Livro__r.Titulo__c,
                Livro__r.Autor__c,
                Leitor__r.Nome__c,
                Leitor__r.Sobrenome__c,
                StatusReserva__c,
                DataReserva__c
            FROM 
                Reserva__c
            WHERE Livro__c =: livroId
        ];
    }
    
    // Defino método para retornar uma lista de Reservas que tenha Leitor__c igual a leitorId
    public List<Reserva__c> buscaReservaPorLeitor(Id leitorId) 
    {
        return [
            SELECT 
                id, 
                Livro__c,
                Leitor__c,
                Livro__r.Titulo__c,
                Livro__r.Autor__c,
                Leitor__r.Nome__c,
                Leitor__r.Sobrenome__c,
                StatusReserva__c,
                DataReserva__c
            FROM 
                Reserva__c
            WHERE Leitor__c =: leitorId
        ];
    }

    // Defino método para atualizar ou inserir um reserva
    public Reserva__c atualizaInsereReserva(Id reservaId, Id livroId, Id leitorId, String status) 
    {
        // Instacio minha classe LivroDAO
        LivroDAO livro = new LivroDAO();

        // Instancio um reserva
        Reserva__c reserva = new Reserva__c();

        // Verifico se o parametro reservaId não está vindo como nulo (vazio)
        if (reservaId != null)
        {
            // Faço uma busca do reserva por ID, atribuindo os valores de retorno para "reserva"
            reserva = buscaReservaPorId(reservaId);
        } 
        else 
        {
            // Verifico se o parametro livroId não está vindo como nulo (vazio)
            if (livroId != null) 
            {
                // Atribuo livroId para o Livro__c de reserva
                reserva.Livro__c = livroId;
            }
            // Verifico se o parametro livroId não está vindo como nulo (vazio)
            if (leitorId != null) 
            {
                // Atribuo leitorId para o Leitor__c de reserva
                reserva.Leitor__c = leitorId;
            }
        }
        
        // Verifico se o parametro livroId não está vindo como nulo (vazio)
        // if (livroId != null) 
        // {
            //Faço uma busca de livro por ID, atribuindo os valores de retorno para "rsLivro"
            // Livro__c rsLivro = livro.buscaLivroPorId(livroId);

            // Realizo o update de rsLivro
            // update rsLivro;
        // }

        // Verifico se o status é diferente de nulo
        if (status != '') 
        {
            // Atribuo o status para o campo reserva.StatusReserva__c
            reserva.StatusReserva__c = status;
        }

        try {
            // Realizo o upsert de "reserva"
            upsert reserva;
        } catch (DmlException e) {
            // Realizo um throw, instaciando um Exception customizado e atribuindo uma mensagem para ele
            throw new ReservaDAOException('Entrar em contato com o suporte');
        }

        return buscaReservaPorId(reserva.Id);
    }

    // Defino método para deletar um Reserva através do parametro reservaId
    public void deletaReserva(Id reservaId) 
    {
        // Busco um reserva por Id
        Reserva__c reserva = buscaReservaPorId(reservaId);

        delete reserva;
    }

    // Defino um método ReservaDAOException que puxa as especificidades da classe Exception 
    public class ReservaDAOException extends Exception {}
}