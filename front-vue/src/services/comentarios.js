import {API} from "../constants";

let comentarios = null;

const comentariosService = {
    /**
     * Retorna los comentarios.
     *
     * @return {Promise<Response | never>}
     */
    getAll: async function() {
        const fetchResponse = await fetch(`${API}/comentarios`, {
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
     * TODO <------------
     * 
     * @param {Number} id
     * @param {{}} data
     * @return {Promise<Response | never>}
     */
    edit: function(id, data) {
        return fetch(`${API}/comentarios/${id}`, {
            method: 'PUT',
            body: JSON.stringify(data),
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
     * TODO <----------------
     *
     * @param {Number} id
     * @return {Promise}
     */
    deleteItem: function(id) {
        return fetch(`${API}/comentarios/${id}`, {
            method: 'DELETE',
            credentials: 'include'
        })
            .then(rta => rta.json())
            .then(response => {
                return response.success;
            });
    }
};

export default comentariosService;
