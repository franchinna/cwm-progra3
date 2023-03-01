<?php

namespace AddCar\Controllers;

use AddCar\Core\View;
use AddCar\Models\Participante;
use AddCar\Validation\Validator;

class APIParticipantesController extends BaseAPIController
{

    public function traerParticipantesPorEvento()
    {
        $id = urlParam('id');

        $participantes = (new Participante)->traerParticipantesPorEvento($id);
        View::renderJson([
            'data' => $participantes
        ]);
    }

    public function confirmoParticipacion()
    {
        $this->requireAuth();

        $json = file_get_contents('php://input');
        $postData = json_decode($json, true);

        $participante = new Participante;

        try {
            $participante->crear($postData);
            View::renderJson([
                'success' => true,
                'data' => $participante
            ]);
        } catch(\Exception $e) {
            View::renderJson([
                'success' => false,
                'error' => "Hubo un error en registrar la asistencia, intentá nuevamente."
            ]);
        }
    }

    public function eliminoParticipacion()
    {
        
        $this->requireAuth();

        $json = file_get_contents('php://input');
        $postData = json_decode($json, true);

        try {
            (new Participante())->eliminar($postData);
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
