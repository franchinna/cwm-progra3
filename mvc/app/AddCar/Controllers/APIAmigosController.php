<?php

namespace AddCar\Controllers;

use AddCar\Core\View;
use AddCar\Models\Amigo;
use AddCar\Validation\Validator;

class APIAmigosController extends BaseAPIController
{

    public function traerAmigosPorUsuario()
    {
        $id = urlParam('id');

        $amigos = (new Amigo)->traerAmigosPorUsuario($id);
        View::renderJson([
            'data' => $amigos
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

        $participante = new Amigo;
        try {
            $participante->crear($id, $postData);
            View::renderJson([
                'success' => true,
                'data' => $participante
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
            (new Amigo())->eliminar($id);
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
