import {API} from "../constants";


let posteos = null;

// Creamos el objeto del servicio.
const posteosService = {
    /**
     * Retorna los posteos.
     *
     * @return {Promise<Response | never>}
     */
    getAll: async function() {
        const fetchResponse = await fetch(`${API}/posteos`, {
//            credentials: 'include'
        });
        const respuesta = await fetchResponse.json();
        posteos = respuesta.data;
        
        return [...posteos];
    },

    /**
     * Retorna los amigos de un usuario.
     *
     * @param {Number} id
     * @return {Promise}
     */
    getPosteos:async function(id) {

        const fetchResponse = await fetch(`${API}/mis_posteos/${id}`, {
            credentials: 'include'
        });
        const respuesta = await fetchResponse.json();
        
        return [...respuesta.data];
    },

    /**
     * Retorna los amigos de un usuario.
     *
     * @param {Number} id
     * @return {Promise}
     */
    posteosDeAmigos:async function(id) {

        const fetchResponse = await fetch(`${API}/posteosAmigos/${id}`, {
            credentials: 'include'
        });
        const respuesta = await fetchResponse.json();
        
        return [...respuesta.data];
    },

    /**
     * Retorna los datos de un posteo.
     *
     * @param {Number} id
     * @return {Promise}
     */
    async getByPk(id) {
        const fetchResponse = await fetch(`${API}/posteos/${id}`, {
            // Por defecto, fetch *no* envía ni recibe cookies.
            // Si quiero permitir el uso de cookies, tengo que explícitamente declararlo con la siguiente
            // propiedad:
            credentials: 'include'
        });
        const respuesta     = await fetchResponse.json();
        
        return {...respuesta.data};
    },

    /**
     * Crea un nuevo posteo en el servidor.
     *
     * @param {{}} data
     * @return {Promise<Response | never>}
     */
    create: function(data) {
        return fetch(`${API}/posteos`, {
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
     * Edita un posteo en el servidor según su id.
     *
     * @param {Number} id
     * @param {{}} data
     * @return {Promise<Response | never>}
     */
    edit: function(id, data) {
        return fetch(`${API}/posteos.php?id=${id}`, {
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
     * Elimina un posteo en el servidor según su id.
     *
     * @param {Number} id
     * @return {Promise}
     */
    deleteItem: function(id) {
        return fetch(`${API}/posteos/${id}`, {
            method: 'DELETE',
            credentials: 'include'
        })
            .then(rta => rta.json())
            .then(response => {
                return response.success;
            });
    }
};

// Exportamos el servicio.
export default posteosService;
