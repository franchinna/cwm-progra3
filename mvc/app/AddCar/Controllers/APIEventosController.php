<?php

namespace AddCar\Controllers;

use AddCar\Core\View;
use AddCar\Models\Evento;
use AddCar\Models\Usuario;
use AddCar\Validation\Validator;

class APIEventosController extends BaseAPIController
{
    public function listar()
    {
        $eventos = (new Evento)->todos();

        View::renderJson([
            'data' => $eventos
        ]);
    }

    public function ver()
    {
        $id = urlParam('id');
        $evento = (new Evento)->traerEvento($id);
        
        View::renderJson([
            'data' => $evento
        ]);
    }

    public function eventosPorUsuario()
    {
        $id = urlParam('id');

        $eventos = (new Evento)->traerEventosPorUsuario($id);
        View::renderJson([
            'data' => $eventos
        ]);
    }

    public function traerUsuariosPorEvento()
    {
        $id = urlParam('id_evento');

        $usuarios = (new Usuario)->traerUsuariosPorEvento($id);
        View::renderJson([
            'data' => $usuarios
        ]);
    }


    public function crear()
    {
        $this->requireAuth();
        $id = urlParam('id');

        $json = file_get_contents('php://input');
        $postData = json_decode($json, true);

        $validator = new Validator($postData, [
            'cuerpo' => ['required', 'min:10']
        ]);

        if(!$validator->passes()) {
            View::renderJson([
                'success' => false,
                'errores' => $validator->getErrores()
            ]);
            exit;
        }

        $evento = new Evento;
        try {
            $evento->crear($id, $postData);
            View::renderJson([
                'success' => true,
                'data' => $evento
            ]);
        } catch(\Exception $e) {
            View::renderJson([
                'success' => false,
            ]);
        }
    }

    public function eliminar()
    {
        $id = urlParam('id');
        try {
            (new Evento())->eliminar($id);
            View::renderJson([
                'success' => true
            ]);
        } catch(\Exception $e) {
            View::renderJson([
                'success' => false,
                'error' => 'Error en la base de datos.'
            ]);
        }
    }
}
