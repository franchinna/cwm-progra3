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
     * Registra al usuario logiado en el evento
     *
     * @param {{}} data
     * @return {Promise<Response | never>}
     */
    create: function(data) {

        return fetch(`${API}/quieroAsistir`, {
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
     * Elimina al usuario logiado en el evento
     *
     *
     *
     */
    deleteItem: function(id, data) {

        return fetch(`${API}/quieroBajarme/${id}`, {
            method: 'DELETE',
            body: JSON.stringify(data),
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
