import {API} from "../constants";
// Creamos una variable para almacenar los amigos.
let amigos = null;

// Creamos el objeto del servicio.
const amigosService = {
    /**
     * Retorna todos los amigos del usaurio logueado.
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
     * Retorna todos los amigos PENDIENTES del usaurio logueado.
     *
     * @param {Number} id
     * @return {Promise<Response | never>}
     */
    traerAmigosPendientes:async function(id) {

        //console.log('id en amigos.js -> ',id);

        const fetchResponse = await fetch(`${API}/pendientes/${id}`, {
            //credentials: 'include'
        });
        const respuesta = await fetchResponse.json();

        amigos = respuesta.data;
        
        //console.log('Respuesta de getByIdUsuario: ',{...amigos});
        return [...amigos];
    },

    /**
     * Retorna todos los NO amigos del usaurio logueado.
     *
     * @param {Number} id
     * @return {Promise<Response | never>}
     */
    traerNoAmigosPorUsuario:async function(id) {

        //console.log('id en amigos.js -> ',id);

        const fetchResponse = await fetch(`${API}/noAmigos/${id}`, {
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
    aceptarAmigo: function(id_usuario, id_amigo) {

        return fetch(`${API}/aceptarAmigo/${id_usuario}/${id_amigo}`, {
            method: 'PUT',
            credentials: 'include'
        })
            .then(rta => rta.json())
            .then(response => {
                return response;
            });
    },

    /**
     * Agrega un amigo en el servidor según su id.
     *
     * @param {Number} id_usuario
     * @param {Number} id_amigo
     * @return {Promise}
     */
    agregarAmigo: function(id_usuario, id_amigo) {

        return fetch(`${API}/agregarAmigo/${id_usuario}/${id_amigo}`, {
            method: 'POST',
            credentials: 'include'
        })
            .then(rta => rta.json())
            .then(response => {
                return response.success;
            });
    },

    /**
     * Elimina un amigo en el servidor según su id.
     *
     * @param {Number} id_usuario
     * @param {Number} id_amigo
     * @return {Promise}
     */
    eliminarAmigo: function(id_usuario, id_amigo) {

        return fetch(`${API}/eliminarAmigo/${id_usuario}/${id_amigo}`, {
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
