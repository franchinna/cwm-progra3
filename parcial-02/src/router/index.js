import Vue from 'vue'
import VueRouter from 'vue-router';

import authService from './../services/auth';

import Home from '@/views/Home.vue';
import Perfil from '@/views/Perfil.vue';
import Amigos from '@/views/Amigos.vue';
import PosteosVer from "@/views/PosteosVer";
import EventosVer from "@/views/EventosVer";
import Login from '@/views/Login.vue';
import Registro from '@/views/Registro.vue';
import PosteoNuevo from "@/views/PosteoNuevo";
import ComentarioNuevo from "@/views/ComentarioNuevo";

Vue.use(VueRouter)

const routes = [
    {
        path: '/',
        name: 'Home',
        component: Home
    },
    {
        path: '/posteonuevo',
        name: 'PosteoNuevo',
        component: PosteoNuevo,
        meta: {
            requiresAuth: true
        }
    },
    {
        path: '/ComentarioNuevo/:id',
        name: 'ComentarioNuevo',
        component: ComentarioNuevo,
        meta: {
            requiresAuth: true
        }
    },
    {
        path: '/posteos/:id',
        name: 'PosteosVer',
        component: PosteosVer
    },
    {
        path: '/eventos/:id',
        name: 'EventosVer',
        component: EventosVer
    },
    {
        path: '/perfil',
        name: 'Perfil',
        component: Perfil,
        meta: {
            requiresAuth: true
        }
    },
    {
        path: '/amigos',
        name: 'Amigos',
        component: Amigos,
        meta: {
            requiresAuth: true
        }
    },
    {
        path: '/login',
        name: 'Login',
        component: Login
    },
    {
        path: '/registro',
        name: 'Registro',
        component: Registro
    },
]

const router = new VueRouter({
    routes
});


router.beforeEach((to, from, next) => {

    if (to.matched.some(item => item.meta.requiresAuth)) {

        if (!authService.isLogged()) {
            next({
                path: '/login'
            });
        } else {
            next();
        }
    } else {
        next();
    }
});


export default router
