-- Execută într-o bază goală, cu proprietarul bazei.
CREATE TABLE carti (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titlu text NOT NULL,
    autor text NOT NULL,
    an_publicare integer NOT NULL CHECK (an_publicare BETWEEN 1 AND 2100)
);
CREATE TABLE cititori (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nume text NOT NULL,
    email text NOT NULL UNIQUE
);
CREATE TABLE imprumuturi (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    carte_id integer NOT NULL REFERENCES carti(id),
    cititor_id integer NOT NULL REFERENCES cititori(id),
    data_imprumut date NOT NULL,
    data_scadenta date NOT NULL,
    data_returnare date,
    CHECK (data_scadenta >= data_imprumut),
    CHECK (data_returnare IS NULL OR data_returnare >= data_imprumut)
);
-- Un exemplar poate avea cel mult un împrumut activ.
CREATE UNIQUE INDEX un_imprumut_activ_per_carte
    ON imprumuturi(carte_id) WHERE data_returnare IS NULL;
CREATE INDEX imprumuturi_cititor_idx ON imprumuturi(cititor_id);
