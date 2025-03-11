# Projeto Lógico

**Usuário**(<u>ID</u>, Username)  
**Amigo**(<u>Amigo1, Amigo2</u>)  
<span style="color: #888; margin-left: 20px;"> Amigo1 -> Usuário(ID)</span>  
<span style="color: #888; margin-left: 20px;"> Amigo2 -> Usuário(ID)</span>  
**Conta**(<u>ID</u>, Senha, Email)  
<span style="color: #888; margin-left: 20px;"> ID -> Usuário(ID)</span>  
**Cartão**(<u>ID, Num, Cod, DT_Exp</u>)  
<span style="color: #888; margin-left: 20px;"> ID -> Conta(ID)</span>  
**Jogo**(<u>ID</u>, Nome, DT_Langamento, Preço)  
**Comentário**(<u>Jogo_ID, Usuário_ID, Data</u>, Estrelas, Descrição)  
<span style="color: #888; margin-left: 20px;"> Jogo_ID -> Jogo(ID)</span>  
<span style="color: #888; margin-left: 20px;"> Usuário_ID -> Usuário(ID)</span>  
**Player**(<u>Usuário_ID</u>)  
<span style="color: #888; margin-left: 20px;"> Usuário_ID -> Usuário(ID)</span>  
**Compartilha**(<u>Jogo_ID, Dependente_ID</u>, Dono_ID!)  
<span style="color: #888; margin-left: 20px;"> Jogo_ID -> Jogo(ID)</span>  
<span style="color: #888; margin-left: 20px;"> Dependente_ID -> Player(ID)</span>  
<span style="color: #888; margin-left: 20px;"> Dono_ID -> Player(ID)</span>  
**Tem**(<u>Usuário_ID, Jogo_ID</u>)  
<span style="color: #888; margin-left: 20px;"> Jogo_ID -> Jogo(ID)</span>  
<span style="color: #888; margin-left: 20px;"> Usuário_ID -> Usuário(ID)</span>  
**Conquistas**(<u>Usuário_ID, Jogo_ID, Conquista</u>)  
<span style="color: #888; margin-left: 20px;"> (Usuário_ID, Jogo_ID) -> Tem(Usuário_ID, Jogo_ID)</span>  
**Dev**(<u>Usuário_ID</u>)  
<span style="color: #888; margin-left: 20px;"> Usuário_ID -> Usuário(ID)</span>  
**Empresa**(<u>ID</u>, nome)  
**Desenvolve**(<u>Usuário_ID, Jogo_ID, Função</u>, Empresa_ID)  
<span style="color: #888; margin-left: 20px;"> Jogo_ID -> Jogo(ID)</span>  
<span style="color: #888; margin-left: 20px;"> Usuário_ID -> Usuário(ID)</span>  
<span style="color: #888; margin-left: 20px;"> Empresa_ID -> Empresa(ID)</span>  

[Clique aqui para acessar esse projeto lógico no Google Docs](https://docs.google.com/document/d/17wE0FC4vY9C_bGEDI3PW7_kOzG-TE_EaEFJH4xZTQTY/edit?usp=sharing)