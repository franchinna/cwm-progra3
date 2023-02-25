import {API} from "../constants";
// Creamos una variable para almacenar los comentarios.
let comentarios = null;

// Creamos el objeto del servicio.
const comentariosService = {
    /**
     * Retorna los comentarios.
     *
     * @return {Promise<Response | never>}
     */
    getAll: async function() {
        const fetchResponse = await fetch(`${API}/comentarios`, {
            // Por defecto, fetch *no* envía ni recibe cookies.
            // Si quiero permitir el uso de cookies, tengo que explícitamente declararlo con la siguiente
            // propiedad:
            credentials: 'include'
        });
        const respuesta     = await fetchResponse.json();
        comentarios = respuesta.data;
        return [...comentarios];
    },

    /**
     * Retorna los datos de un comentario.
     *
     * @param {Number} id
     * @return {Promise}
     */
    async getByPk(id) {
        const fetchResponse = await fetch(`${API}/comentarios/${id}`, {
            // Por defecto, fetch *no* envía ni recibe cookies.
            // Si quiero permitir el uso de cookies, tengo que explícitamente declararlo con la siguiente
            // propiedad:
            credentials: 'include'
        });
        const respuesta     = await fetchResponse.json();
        comentarios = respuesta.data;
        return [...comentarios];
    },

    /**
     * Crea un nuevo comentario en el servidor.
     *
     * @param {Number} id
     * @param {{}} data
     * @return {Promise<Response | never>}
     */
    create: function(id,data) {

        return fetch(`${API}/comentarios/${id}`, {
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
        return fetch(`${API}/comentarios/${id}`, {
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
        return fetch(`${API}/comentarios/${id}`, {
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
export default comentariosService;
