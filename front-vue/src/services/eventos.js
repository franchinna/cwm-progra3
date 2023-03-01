import {API} from "../constants";

let eventos = null;

const eventosService = {
    /**
     * Retorna los eventos del site.
     *
     * @return {Promise<Response | never>}
     */
    getAll: async function() {
        const fetchResponse = await fetch(`${API}/eventos`, { });
        const respuesta     = await fetchResponse.json();
        eventos = respuesta.data;
        
        return [...eventos];
    },

    /**
     * Retorna los datos de un evento segun su ID.
     *
     * @param {Number} id
     * @return {Promise}
     */
    async getByPk(id) {
        const fetchResponse = await fetch(`${API}/eventos/${id}`, {
            credentials: 'include'
        });
        const respuesta     = await fetchResponse.json();

        return {...respuesta.data};
    },

    /**
     * Retorna los paticipantes de un Evento segun su ID.
     *
     * @param {Number} id
     * @return {Promise<Response | never>}
     */
    getParticipantes:async function(id) {

        const fetchResponse = await fetch(`${API}/participantes/${id}`, { });
        const respuesta = await fetchResponse.json();

        eventos = respuesta.data;
        
        return [...eventos];
    },

    /**
     * Crea un nuevo evento en el servidor.
     *
     * TODO <------     QUE LOS USUARIOS PUEDAN CREAR EVENTOS MANUALMENTE
     * 
     * @param {Number} id
     * @param {{}} data
     * @return {Promise<Response | never>}
     */
    create: function(id,data) {

        return fetch(`${API}/eventos/${id}`, {
            method: 'POST',
            body: JSON.stringify(data),
            credentials: 'include'
        })
            .then(rta => rta.json())
            .then(response => {
                return response;
            });
    },

    /**
     * Edita un comentario en el servidor según el id del evento.
     *
     * TODO <------     QUE LOS USUARIOS PUEDAN EDIT EVENTOS MANUALMENTE
     * 
     * @param {Number} id
     * @param {{}} data
     * @return {Promise<Response | never>}
     */
    edit: function(id, data) {
        return fetch(`${API}/eventos/${id}`, {
            method: 'PUT',
            body: JSON.stringify(data),
            // Por defecto, fetch *no* envía ni recibe cookies.
            // Si quiero permitir el uso de cookies, tengo que explícitamente declararlo con la siguiente
            // propiedad:
            credentials: 'include'
        })
            .then(rta => rta.json())
            .then(response => {
                return response;
            });
    },

    /**
     * Elimina un comentario en el servidor según el id del evento.
     *
     * TODO <------     QUE LOS USUARIOS PUEDAN DELETE EVENTOS MANUALMENTE
     * 
     * @param {Number} id
     * @return {Promise}
     */
    deleteItem: function(id) {
        return fetch(`${API}/eventos/${id}`, {
            method: 'DELETE',
            // Por defecto, fetch *no* envía ni recibe cookies.
            // Si quiero permitir el uso de cookies, tengo que explícitamente declararlo con la siguiente
            // propiedad:
            credentials: 'include'
        })
            .then(rta => rta.json())
            .then(response => {
                return response.success;
            });
    }
};

export default eventosService;
