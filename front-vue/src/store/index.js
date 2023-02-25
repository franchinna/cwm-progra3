const store = {
    /**
     * Si deben mostrarse mensajes de depuración o no.
     */
    debug: true,
    status: {
        mensaje: null,
        titulo: null,
        tipo: null
    },
    auth: {
        id: null,
        email: null,
        usuario: null,
        imagen: null,
    },

    /**
     * Actualiza el status con los datos provistos.
     *
     * @param {{}} newStatus
     */
    setStatus(newStatus) {
        if(this.debug) {
            console.log("Store :: setStatus invocado con: ", newStatus);
        }
        this.status = {
            ...this.status,
            ...newStatus,
        }
    },
    /**
     * Limpia los valores de status y los vuelve a null a todos.
     */
    clearStatus() {
        if(this.debug) {
            console.log("Store :: clearStatus invocado");
        }
        this.status = {
            mensaje: null,
            titulo: null,
            tipo: null,
        }
    }
};

export default store;
