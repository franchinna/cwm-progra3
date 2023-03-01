import {API} from "../constants";

let participantes = null;


const participantesService = {
    /**
     * Retorna los participantes.
     *
     * @return {Promise<Response | never>}
     */
    getAll: async function() {
        const fetchResponse = await fetch(`${API}/participantes`, { });
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


        const fetchResponse = await fetch(`${API}/participantes/${id}`, { });
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
     * Elimina al usuario logiado en el eventO
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
