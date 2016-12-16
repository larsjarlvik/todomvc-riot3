import * as redux from 'redux';

const STORAGE_KEY = 'todomvc-riot-store';

const reducer = (state, action) => {
    state = state || { todos: [], remaining: 0 };

    switch(action.type) {
        case 'init':
            return init();
        case 'add':
            return add(state, action.todo);
        case 'edit':
            return edit(state, action.todo, action.newTitle);
        case 'toggleCompleted':
            return toggleCompleted(state, action.todo);
        case 'toggleAllCompleted':
            return toggleAllCompleted(state);
        case 'remove':
            return remove(state, action.todo);
        case 'filter':
            return filter(state, action.activeFilter);
    }

    return state;
};

function init() {
    const todos = JSON.parse(localStorage.getItem(STORAGE_KEY) || '[]');
    
    return {
        todos,
        remaining: getRemaining(todos),
        activeFilter: 'all'
    };
}

function add(state, todo) {
    if(todo.title && todo.title.trim())
        state.todos.push(todo);

    return { todos: store(state.todos), remaining: getRemaining(state.todos) };
}

function edit(state, todo, newTitle) {
    if(!newTitle || !newTitle.trim())
        return remove(state, todo);

    const fTodos = state.todos.map((t) => {
        if(t === todo) { t.title = newTitle; }
        return t;
    });

    return { todos: store(fTodos), remaining: getRemaining(fTodos) };
}

function toggleCompleted(state, todo) {
    const fTodos = state.todos.map((t) => {
        if(t === todo) { t.completed = !todo.completed; }
        return t;
    });

    return { todos: store(fTodos), remaining: getRemaining(fTodos) };
}

function toggleAllCompleted(state) {
    const remaining = getRemaining(state.todos);
    let setCompleted = true;

    if(remaining === 0)
        setCompleted = false;

    const fTodos = state.todos.map((t) => {
        t.completed = setCompleted;
        return t;
    });

    return { todos: store(fTodos), remaining: getRemaining(fTodos) };
}

function remove(state, todo) {
    const fTodos = state.todos.filter((t) => t !== todo);
    return { todos: store(fTodos), remaining: getRemaining(fTodos) };
}

function filter(state, activeFilter) {
    state.activeFilter = activeFilter;
    return state;
}


function getRemaining(todos) {
    return todos.filter((t) => !t.completed).length;
}

function store(todos) {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(todos));
    return todos;
}

export default redux.createStore(reducer);