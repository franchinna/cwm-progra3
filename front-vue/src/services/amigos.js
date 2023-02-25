import {API} from "../constants";
// Creamos una variable para almacenar los amigos.
let amigos = null;

// Creamos el objeto del servicio.
const amigosService = {
    /**
     * Retorna los amigos.
     *
     * @return {Promise<Response | never>}
     */
    getAll: async function() {
        const fetchResponse = await fetch(`${API}/amigos`, {
            // Por defecto, fetch *no* envía ni recibe cookies.
            // Si quiero permitir el uso de cookies, tengo que explícitamente declararlo con la siguiente
            // propiedad:
            //credentials: 'include'
        });
        const respuesta     = await fetchResponse.json();
        amigos = respuesta.data;
        
        return [...amigos];
    },

    /**
     * Retorna los datos de un comentario.
     *
     * @param {Number} id
     * @return {Promise<Response | never>}
     */
    traerAmigosPorUsuario:async function(id) {

        //console.log('id en amigos.js -> ',id);

        const fetchResponse = await fetch(`${API}/amigos/${id}`, {
            //credentials: 'include'
        });
        const respuesta = await fetchResponse.json();

        amigos = respuesta.data;
        
        //console.log('Respuesta de getByIdUsuario: ',{...amigos});
        return [...amigos];
    },

    /**
     * Crea un nuevo comentario en el servidor.
     *
     * @param {Number} id
     * @param {{}} data
     * @return {Promise<Response | never>}
     */
    create: function(id,data) {

        return fetch(`${API}/amigos/${id}`, {
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
        return fetch(`${API}/amigos/${id}`, {
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
        return fetch(`${API}/amigos/${id}`, {
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
export default amigosService;
