import route from "riot-route";

export default {
    start: (store) => {
        route('/*', (name) => {
            name = name || 'all';
            store.dispatch({ type: 'filter', activeFilter: name });
        });

        route.start(true);
    }
};
