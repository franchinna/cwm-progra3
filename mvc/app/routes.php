<?php

use AddCar\Core\Route;

//Auth
Route::add('POST', '/api/login', 'APIAuthController@login');
Route::add('POST', '/api/logout', 'APIAuthController@logout');

//Usuarios
Route::add('POST', '/api/registrarUsuario', 'APIUserController@crearUsuario');
Route::add('GET', '/api/usuarios/{id}', 'APIUserController@ver');
Route::add('PUT', '/api/usuarios/{id}', 'APIUserController@editar');
Route::add('OPTIONS', '/api/usuarios/{id}', 'APIUserController@editar');

//Amigos
Route::add('GET', '/api/amigos/{id}', 'APIAmigosController@traerAmigosPorUsuario');

//Participantes
Route::add('GET', '/api/participantes/{id}', 'APIParticipantesController@traerParticipantesPorEvento');

//Favoritos
Route::add('GET', '/api/mis_favoritos/{id}', 'APIUserController@listarFavoritos');

//Posteos
Route::add('GET', '/api/posteos', 'APIPosteosController@listar');
Route::add('POST', '/api/posteos', 'APIPosteosController@crear');
Route::add('GET', '/api/posteos/{id}', 'APIPosteosController@ver');
Route::add('GET', '/api/mis_posteos/{id}', 'APIPosteosController@listarMisPosteos');


//Comentarios
Route::add('GET', '/api/comentarios/{id}', 'APIComentariosController@todosPorPosteo');
Route::add('POST', '/api/comentarios/{id}', 'APIComentariosController@crear');

//Eventos
Route::add('GET', '/api/eventos', 'APIEventosController@listar');
Route::add('POST', '/api/eventos', 'APIEventosController@crear');
Route::add('GET', '/api/eventos/{id}', 'APIEventosController@ver');


