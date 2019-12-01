-- Resources
CREATE SCHEMA IF NOT EXISTS api;

CREATE TABLE api.usuario (
	id BIGSERIAL PRIMARY KEY,
	nome TEXT NOT NULL,
	email TEXT UNIQUE,
	senha TEXT NOT NULL,
	"dataCriacao" TIMESTAMP DEFAULT now()
);

CREATE TABLE api.loja (
	id BIGSERIAL PRIMARY KEY,
	nome TEXT NOT NULL,
	descricao TEXT NOT NULL,
	"usuarioId" BIGINT NOT NULL REFERENCES usuario(id),
	avaliavao INT,
	foto BYTEA
);

CREATE TABLE api."lojaFavorita" (
	"lojaId" BIGINT NOT NULL REFERENCES loja(id),
	"usuarioId" BIGINT NOT NULL REFERENCES usuario(id),
	PRIMARY KEY (loja_id, usuario_id)
);

CREATE TABLE api.item (
	id BIGSERIAL PRIMARY KEY,
	"lojaId" BIGINT NOT NULL REFERENCES loja(id),
	nome TEXT NOT NULL,
	preco NUMERIC(24,3) NOT NULL
);

CREATE TABLE api."imagemItem" (
	id BIGSERIAL PRIMARY KEY,
	"itemId" BIGINT REFERENCES item(id),
	content BYTEA
)

CREATE TABLE api.pagamento (
	id BIGSERIAL PRIMARY KEY,
	"dataPag" TIMESTAMP,
	valor NUMERIC(24,3),
	"usuarioId" BIGINT NOT NULL REFERENCES usuario(id)
);

-- Auth
CREATE ROLE web_anon NOLOGIN;
GRANT USAGE ON SCHEMA api TO web_anon;
GRANT SELECT ON ALL TABLES IN SCHEMA api TO web_anon;
GRANT ALL ON ALL TABLES IN SCHEMA api TO web_anon; -- TODO: split responsability and add proper authentication

CREATE ROLE authenticator NOINHERIT LOGIN PASSWORD :authenticatorPass;
GRANT web_anon TO authenticator;
