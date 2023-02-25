import {API} from "../constants";

let userData = {
    id: null,
    email: null,
    usuario: null,
    imagen: null,
};

const authService = {
    /**
     * Trata de autenticar al usuario contra la API.
     *
     * @param {{}} credenciales
     * @param {String} credenciales.email
     * @param {String} credenciales.password
     * @return Promise
     */
    login(credenciales) {
        return fetch(`${API}/login`, {
            method: 'POST',
            body: JSON.stringify(credenciales),
            credentials: 'include'
        })
            .then(res => res.json())
            .then(res => {
                console.log(res);

                if(!res.success) {
                    return false;
                }

                const usuario = res.data.usuario;
                userData = {
                    ...usuario
                };

                return {
                    ...userData
                };
            });
    },

    /**
     * Cierra sesión.
     *
     * @return Promise
     */
    logout() {
        return fetch(`${API}/logout`, {
            method: 'POST',
            credentials: 'include'
        })
            .then(rta => rta.json())
            .then(res => {
                userData = {
                    id: null,
                    email: null,
                    usuario: null,
                    imagen: null,
                };
                return res;
            });
    },

    /**
     * Loguea forzosamente al usuario provisto como argumento.
     *
     * @param {{}} user
     * @param {{}} user.id
     * @param {{}} user.email
     * @param {{}} user.username
     * @param {{}} user.imagen
     */
    logUser(user) {
        userData = {...user};
    },

    /**
     * Retorna true si el usuario está autenticado.
     * false de lo contrario.
     *
     * @return {boolean}
     */
    isLogged: function() {
        return userData.id !== null;
    }
};

export default authService;
