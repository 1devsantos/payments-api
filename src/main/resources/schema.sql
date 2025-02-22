CREATE TABLE IF NOT EXISTS tb_users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS tb_transactions (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL CHECK (payment_method IN ('PIX', 'CARTÃO', 'BOLETO')),
    status VARCHAR(50) NOT NULL CHECK (status IN ('PENDENTE', 'APROVADO', 'RECUSADO')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES tb_users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tb_external_payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    transaction_id BIGINT NOT NULL,
    gateway VARCHAR(255) NOT NULL,
    external_references TEXT NOT NULL,
    status VARCHAR(50) NOT NULL CHECK (status IN ('PENDENTE', 'APROVADO', 'RECUSADO')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (transaction_id) REFERENCES tb_transactions(id) ON DELETE CASCADE
);