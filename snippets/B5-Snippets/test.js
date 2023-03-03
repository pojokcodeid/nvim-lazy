var jsonConcat = require("json-concat");

jsonConcat({
    src: [
        "snippets/types/utility.json",
        "snippets/types/modal.json",
        "snippets/types/navigation.json",
        "snippets/types/carousel.json",
        "snippets/types/grid.json",
        "snippets/types/buttons.json",
        "snippets/types/collapse.json",
        "snippets/types/cards.json",
        "snippets/types/pagination.json",
        "snippets/types/breadcrumb.json",
        "snippets/types/content.json",
        "snippets/types/forms.json",
        "snippets/types/list-group.json",
        "snippets/types/progressbar.json",
        "snippets/types/fonts.json",
        "snippets/types/templates.json"
    ],
    dest: "snippets/bootstrap.json"
}, function (json) {
    console.log(json);
});

// "snippets/types/utility.json",
// "snippets/types/templates.json"