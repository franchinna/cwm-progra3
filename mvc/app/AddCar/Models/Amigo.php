<?php

namespace AddCar\Models;

use AddCar\DB\DBConnection;
use Exception;
use JsonSerializable;
use PDO;


class Amigo extends Modelo implements JsonSerializable
{
    /** @var string La tabla contra la que mapea la clase. */
    protected $table = "amigos";

    protected $id_usuario;
    protected $id_amigo;
    protected $status;
    protected $userimg;
    protected $username;



    /** @var array Lista de los atributos que permitidos cargar en nuestra clase. */
    protected $atributosPermitidos = [
        'id_usuario',
        'id_amigo',
        'status',
        'userimg',
        'username'
    ];

    public function jsonSerialize()
    {
        return [
            'id_usuario' => $this->getIdUsuario(),
            'id_amigo' => $this->getIdAmigo(),
            'status' => $this->getStatus(),
            'userimg' => $this->getUserImg(),
            'username' => $this->getUserName(),
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
     * Retorna un array con todos los amigos.
     * Cada amigo va a esta representado como una instancia de amigo.
     *
     * @return Amigo[]
     */
    public function traerAmigosPorUsuario($id_usuario)
    {
        $db = DBConnection::getConnection();

        $query = "
                SELECT a.*, u.usuario as username, u.imagen as userimg 
                FROM amigos a
                INNER JOIN usuarios u on u.id = a.id_amigo
                where a.id_usuario = ? AND a.status = 1;
                ";

        $stmt = $db->prepare($query);
        $stmt->execute([$id_usuario]);

        $salida = [];

        while ($fila = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $amigo = new Amigo;
            $amigo->massAssignament($fila);
            $salida[] = $amigo;
        }

        return $salida;
    }

    /**
     * Retorna un array con todos los amigos.
     * Cada amigo va a esta representado como una instancia de amigo.
     *
     * @return Amigo[]
     */
    public function traerAmigosPendientesPorUsuario($id_usuario)
    {
        $db = DBConnection::getConnection();

        $query = "
                SELECT a.*, u.usuario as username, u.imagen as userimg 
                FROM amigos a
                INNER JOIN usuarios u on u.id = a.id_amigo
                where a.id_usuario = ? AND a.status = 0
                ";


        $stmt = $db->prepare($query);
        $stmt->execute([$id_usuario]);

        $salida = [];

        while ($fila = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $amigo = new Amigo;
            $amigo->massAssignament($fila);
            $salida[] = $amigo;
        }

        return $salida;
    }

    /**
     * Retorna un array con todos los amigos.
     * Cada amigo va a esta representado como una instancia de amigo.
     *
     * @return Amigo[]
     */
    public function traerNoAmigosPorUsuario($id_usuario)
    {
        $db = DBConnection::getConnection();

        $query = "SELECT u.usuario as username, u.id as id_amigo, u.imagen as userimg 
                    FROM usuarios u WHERE id NOT IN (
                    SELECT id_usuario 
                    FROM Amigos 
                    WHERE id_amigo = :id_usuario1 AND status = 1) 
                    AND u.id != :id_usuario2;";

        $stmt = $db->prepare($query);
        $stmt->execute([
            ':id_usuario1' => $id_usuario,
            ':id_usuario2' => $id_usuario
        ]);

        $salida = [];

        while ($fila = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $amigo = new Amigo;
            $amigo->massAssignament($fila);
            $salida[] = $amigo;
        }

        return $salida;
    }

    /**
     * Crea un registro de Amigo en la tabla amigos
     *
     * @param string $id_amigo
     * @param string $id_usuario
     * @throws Exception
     */
    public function agregarAmigo($id_usuario, $id_amigo)
    {

        $db = DBConnection::getConnection();
        $query = "INSERT INTO `db_addcar`.`amigos` (`id_usuario`, `id_amigo`, `status`) VALUES (:id_amigo, :id_usuario, '0');";

        $stmt = $db->prepare($query);
        $exito = $stmt->execute([
            'id_amigo' => (string) $id_amigo,
            'id_usuario' => (string) $id_usuario
        ]);

        if (!$exito) {
            throw new Exception('Ups! Hubo un error en agregar a tu amigo, intentá nuevamente. Si el error persiste, ponete en contacto con el soporte');
        }

        $data['id_usuario'] = $db->lastInsertId();

        $this->massAssignament($data);
    }

    /**
     * Actualiza el status de un amigo de pendienta a aceptado
     *
     * @param string $id_amigo
     * @param string $id_usuario
     * @throws Exception
     */
    public function aceptarAmigo($id_usuario, $id_amigo)
    {

        $db = DBConnection::getConnection();

        $query = "INSERT INTO amigos (id_usuario, id_amigo, status) VALUES (:id_amigo, :id_usuario, '1');";

        $stmt = $db->prepare($query);
        $exito = $stmt->execute([
            'id_amigo' => (string) $id_amigo,
            'id_usuario' => (string) $id_usuario,
        ]);

        if (!$exito) {
            throw new Exception('Ups! Hubo un error en aceptar a tu amigo, intentá nuevamente. Si el error persiste, ponete en contacto con el soporte');
        }

        $data['id_usuario'] = $db->lastInsertId();

        $this->massAssignament($data);
        
        $this->actualizarRelacionEntreUsaarios($id_usuario, $id_amigo);
    }

    /**
     * Crea un registro en la tabla con la $data proporcionada.
     *
     * @param int $id_usuario
     * @param int $id_amigo
     * @throws Exception
     */
    public function actualizarRelacionEntreUsaarios($id_usuario, $id_amigo)
    {
        $db = DBConnection::getConnection();

        $query = "UPDATE amigos SET status = 1 WHERE (id_usuario = :id_usuario) and (id_amigo = :id_amigo)";

        $stmt = $db->prepare($query);
        $exito = $stmt->execute([
            'id_amigo' => (string) $id_amigo,
            'id_usuario' => (string) $id_usuario
        ]);

        if (!$exito) {
            throw new Exception('Ups! Hubo un error en aceptar a tu amigo, intentá nuevamente. Si el error persiste, ponete en contacto con el soporte');
        }

        $data['id_usuario'] = $db->lastInsertId();

        $this->massAssignament($data);
    }

    /**
     * Elimina un registro en la tabla
     *
     * @param string $id_amigo
     * @param string $id_usuario
     * @throws Exception
     */
    public function eliminarAmigo($id_usuario, $id_amigo)
    {

        $db = DBConnection::getConnection();

        $query = "DELETE FROM `db_addcar`.`amigos` WHERE (`id_usuario` = :id_usuario) and (`id_amigo` = :id_amigo);";

        $stmt = $db->prepare($query);
        $exito = $stmt->execute([
            'id_amigo' => (string) $id_amigo,
            'id_usuario' => (string) $id_usuario,
        ]);

        $query = "DELETE FROM `db_addcar`.`amigos` WHERE (`id_usuario` = :id_amigo) and (`id_amigo` = :id_usuario);";

        $stmt = $db->prepare($query);
        $exito = $stmt->execute([
            'id_amigo' => (string) $id_amigo,
            'id_usuario' => (string) $id_usuario,
        ]);

        if (!$exito) {
            throw new Exception('Ups! Hubo un error en eliminar a tu amigo, intentá nuevamente. Si el error persiste, ponete en contacto con el soporte');
        }

        $data['id_usuario'] = $db->lastInsertId();

        $this->massAssignament($data);
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
    public function getIdAmigo()
    {
        return $this->id_amigo;
    }

    /**
     * @param mixed $id_amigo
     */
    public function setIdEvento($id_amigo)
    {
        $this->id_amigo = $id_amigo;
    }
    /**
     * @return mixed
     */
    public function getStatus()
    {
        return $this->status;
    }

    /**
     * @param mixed $status
     */
    public function setStatus($status)
    {
        $this->status = $status;
    }


    /**
     * @return mixed
     */
    public function getUserImg()
    {
        return $this->userimg;
    }

    /**
     * @param mixed $userimg
     */
    public function setUserImg($userimg)
    {
        $this->userimg = $userimg;
    }
    /**
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
