import {API} from "../constants";
// Creamos una variable para almacenar los eventos.
let eventos = null;

// Creamos el objeto del servicio.
const eventosService = {
    /**
     * Retorna los eventos.
     *
     * @return {Promise<Response | never>}
     */
    getAll: async function() {
        const fetchResponse = await fetch(`${API}/eventos`, {
            // Por defecto, fetch *no* envía ni recibe cookies.
            // Si quiero permitir el uso de cookies, tengo que explícitamente declararlo con la siguiente
            // propiedad:
            //credentials: 'include'
        });
        const respuesta     = await fetchResponse.json();
        eventos = respuesta.data;
        
        return [...eventos];
    },

    /**
     * Retorna los datos de un evento.
     *
     * @param {Number} id
     * @return {Promise}
     */
    async getByPk(id) {
        const fetchResponse = await fetch(`${API}/eventos/${id}`, {
            credentials: 'include'
        });
        const respuesta     = await fetchResponse.json();

        //console.log({...respuesta.data});

        return {...respuesta.data};
    },

    /**
     * Retorna los participantes de un evento.
     *
     * @param {Number} id
     * @return {Promise}
     */
    getAmigos:async function(id) {

        const fetchResponse = await fetch(`${API}/mis_amigos/${id}`, {
            credentials: 'include'
        });
        const respuesta = await fetchResponse.json();
        
        return [...respuesta.data];
    },

    /**
     * Retorna los datos de un comentario.
     *
     * @param {Number} id
     * @return {Promise<Response | never>}
     */
    getParticipantes:async function(id) {

        //console.log('id en eventos.js -> ',id);

        const fetchResponse = await fetch(`${API}/participantes/${id}`, {
            //credentials: 'include'
        });
        const respuesta = await fetchResponse.json();

        eventos = respuesta.data;
        
        //console.log('Respuesta de getByIdUsuario: ',{...eventos});
        return [...eventos];
    },

    /**
     * Crea un nuevo comentario en el servidor.
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
     * Edita un comentario en el servidor según su id.
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
     * Elimina un comentario en el servidor según su id.
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

// Exportamos el servicio.
export default eventosService;
