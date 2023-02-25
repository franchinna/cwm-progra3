import {API} from "../constants";

let usuario = null;

const UsersService = {
    /**
     * Crea un nuevo usuario en el servidor.
     *
     * @param {{}} data
     * @return {Promise<Response | never>}
     */
    create: function (data){
        return fetch(`${API}/registrarUsuario`, {
            method: 'POST',
            body: JSON.stringify(data),
        })
            .then(rta => rta.json())
            .then(response => {
                return response;
            })
    },
    /**
     * Retorna los datos de un usuario.
     *
     * @param {Number} id
     * @return {Promise}
     */
    async getByPk(id) {
        const fetchResponse = await fetch(`${API}/usuarios/${id}`, {
            credentials: 'include'
        });
        const respuesta     = await fetchResponse.json();
        return {...respuesta.data};
    },

    /**
     * Retorna los amigos de un usuario.
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
     * Edita un producto en el servidor según su id.
     *
     * @param {Number} id
     * @param {{}} data
     * @return {Promise<Response | never>}
     */
    edit: function(id, data) {
        return fetch(`${API}/usuarios/${id}`, {
            method: 'PUT',
            body: JSON.stringify(data)
        })
            .then(rta => rta.json())
            .then(response => {
                return response;
            });
    },
};

export default UsersService;