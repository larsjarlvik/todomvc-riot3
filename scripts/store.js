'use strict';

var STORAGE_KEY = 'todos-riotjs';

const store = {
    fetch: function () {
        return JSON.parse(localStorage.getItem(STORAGE_KEY) || '[]');
    },
    save: function (todos) {
        localStorage.setItem(STORAGE_KEY, JSON.stringify(todos));
    }
};

export default store;