import {API} from "../constants";
// Creamos una variable para almacenar los participantes.
let participantes = null;

// Creamos el objeto del servicio.
const participantesService = {
    /**
     * Retorna los participantes.
     *
     * @return {Promise<Response | never>}
     */
    getAll: async function() {
        const fetchResponse = await fetch(`${API}/participantes`, {
            // Por defecto, fetch *no* envía ni recibe cookies.
            // Si quiero permitir el uso de cookies, tengo que explícitamente declararlo con la siguiente
            // propiedad:
            //credentials: 'include'
        });
        const respuesta     = await fetchResponse.json();
        participantes = respuesta.data;
        
        return [...participantes];
    },

    /**
     * Retorna los datos de un comentario.
     *
     * @param {Number} id
     * @return {Promise<Response | never>}
     */
    traerUsuariosPorEvento:async function(id) {

        //console.log('id en participantes.js -> ',id);

        const fetchResponse = await fetch(`${API}/participantes/${id}`, {
            //credentials: 'include'
        });
        const respuesta = await fetchResponse.json();

        participantes = respuesta.data;
        
        //console.log('Respuesta de getByIdUsuario: ',{...participantes});
        return [...participantes];
    },

    /**
     * Crea un nuevo comentario en el servidor.
     *
     * @param {Number} id
     * @param {{}} data
     * @return {Promise<Response | never>}
     */
    create: function(id,data) {

        return fetch(`${API}/participantes/${id}`, {
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
        return fetch(`${API}/participantes/${id}`, {
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
        return fetch(`${API}/participantes/${id}`, {
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
export default participantesService;
