INSERT INTO eval_types (id, description_en)
VALUES (
        'simple',
        'Predetermined stdin with one and only one correct stdout.'
    ),
    (
        'checker',
        'Predetermined stdin with one or more correct std outputs. Output checked by checker.'
    ),
    (
        'interactive',
        'Stdin determined during execution by the interactor. Output checked by checker.'
    );