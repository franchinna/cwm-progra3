<?php

namespace AddCar\Models;

use AddCar\DB\DBConnection;
use Exception;
use JsonSerializable;
use PDO;


class Participante extends Modelo implements JsonSerializable
{
    /** @var string La tabla contra la que mapea la clase. */
    protected $table = "participantes";
    /** @var string La primary key. */
    protected $pk = "id";

    protected $id;
    protected $id_usuario;
    protected $id_evento;
    protected $asistencia;
    protected $userimg;
    protected $username;



    /** @var array Lista de los atributos que permitidos cargar en nuestra clase. */
    protected $atributosPermitidos = [
        'id',
        'id_usuario',
        'id_evento',
        'asistencia',
        'userimg',
        'username'
    ];

    public function jsonSerialize()
    {
        return [
            'id' => $this->getIdParticipante(),
            'id_usuario' => $this->getIdUsuario(),
            'id_evento' => $this->getIdEvento(),
            'asistencia' => $this->getAsistencia(),
            'userimg' => $this->getuserimg(),
            'username' => $this->getUsername(),
        ];
    }

    /**
     * Carga todos los datos provistos en $data en las propiedades de la instancia, siempre y cuando figuren en la propiedad $atributosPermitidos.
     *
     * @param array $data
     */
    public function massAssignament(array $data)
    {
        foreach ($this->atributosPermitidos as $attr) {
            if (isset($data[$attr])) {
                $this->{$attr} = $data[$attr];
            }
        }
    }

    /**
     * Retorna un array con todos los participantes.
     * Cada participante va a esta representado como una instancia de participante.
     *
     * @return Participante[]
     */
    public function traerParticipantesPorEvento($id_evento)
    {
        $db = DBConnection::getConnection();

        $query = "
                SELECT p.*, u.usuario as username, u.imagen as userimg
                FROM participantes p
                    INNER JOIN usuarios u ON u.id = p.id_usuario
                WHERE p.id_evento = ?
                ";

        $stmt = $db->prepare($query);
        $stmt->execute([$id_evento]);

        $salida = [];

        while ($fila = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $participante = new Participante;
            $participante->massAssignament($fila);
            $salida[] = $participante;
        }

        return $salida;
    }

    /**
     * Crea un registro en la tabla con la $data proporcionada.
     *
     * @param array $data
     * @throws Exception
     */
    public function crear(array $data)
    {

        $db = DBConnection::getConnection();

        $query = "INSERT INTO `participantes` (`id_evento`, `id_usuario`) VALUES (:id_evento, :id_usuario)";

        $stmt = $db->prepare($query);
        $exito = $stmt->execute([
            'id_evento' => $data['id_evento'],
            'id_usuario' => $data['id_usuario'],
        ]);

        if (!$exito) {
            throw new Exception('Hubo un error en registrar la asistencia, intentá nuevamente.');
        }

        $data['id'] = $db->lastInsertId();

        $this->massAssignament($data);
    }

    /**
     * Elimina un registro en la tabla con la $data proporcionada.
     *
     * @param array $data
     * @throws Exception
     */
    public function eliminar(array $data)
    {

        $db = DBConnection::getConnection();

        $query = "DELETE FROM `participantes` WHERE (`id_usuario` = :id_usuario AND `id_evento` = :id_evento);";

        $stmt = $db->prepare($query);
        $exito = $stmt->execute([
            'id_evento' => $data['id_evento'],
            'id_usuario' => $data['id_usuario'],
        ]);

        if (!$exito) {
            throw new Exception('Hubo un error en registrar la asistencia, intentá nuevamente.');
        }

        $data['id'] = $db->lastInsertId();

        $this->massAssignament($data);
    }

    /**
     * @return mixed
     */
    public function getIdParticipante()
    {
        return $this->id;
    }

    /**
     * @param mixed $id
     */
    public function setIdParticipante($id)
    {
        $this->id = $id;
    }

    /**
     * @return mixed
     */
    public function getIdUsuario()
    {
        return $this->id_usuario;
    }

    /**
     * @param mixed $id_usuario
     */
    public function setIdUsuario($id_usuario)
    {
        $this->id_usuario = $id_usuario;
    }

    /**
     * @return mixed
     */
    public function getIdEvento()
    {
        return $this->id_evento;
    }

    /**
     * @param mixed $id_evento
     */
    public function setIdEvento($id_evento)
    {
        $this->id_evento = $id_evento;
    }
    /**
     * @return mixed
     */
    public function getAsistencia()
    {
        return $this->asistencia;
    }

    /**
     * @param mixed $asistencia
     */
    public function setAsistencia($asistencia)
    {
        $this->asistencia = $asistencia;
    }
    
    /**
     * @return mixed
     */
    public function getuserimg()
    {
        return $this->userimg;
    }

    /**
     * @param mixed $userimg
     */
    public function setuserimg($userimg)
    {
        $this->userimg = $userimg;
    }/**
     * @return mixed
     */
    public function getUsername()
    {
        return $this->username;
    }

    /**
     * @param mixed $username
     */
    public function setUsername($username)
    {
        $this->username = $username;
    }

}