# flutter_versionamento

A Flutter Application Using API Versioning.

Packages utilizados
  * dio: ^3.0.0
  *	http: ^0.12.0+2
  *	rxdart: ^0.22.2
  *	url_launcher: ^5.1.3
  *	package_info: ^0.4.0+6

Permissão necessária no **AndroidManifest.xml**
  * \<uses-permission android:name="android.permission.INTERNET"/>

Ao iniciar o aplicativo é chamada a função **_initPackageInfo()** para recuperar a versão do app instalado, em sequência vem a **versionamento()** a qual envia para o bando para validação e retorna com 3 itens:
  *	**SUCCESS**
  *	**MSG**
  *	**TOKEN**

Após esse retorno é feito o tratamento com a possibilidade de 3 situações:
1.	caso:\
Se **SUCCESS** for igual a **true** e **MSG** não contiver nenhuma mensagem
o usuário será redirecionado para a tela de login.
2.	caso:\
Se **SUCCESS** for igual a **true** e **MSG** contiver alguma mensagem. Será exibido um pop up ao usuário informando que a versão está ficando obsoleta e só será possível utilizar o App até a data limite, após a mensagem o usuário será redirecionado para a tela de login.
3.	caso:\
Se **SUCCESS** for igual a **false**. Será exibido um pop up com a mensagem informando as versões do App liberadas e exigindo que o App seja atualização. O usuário só conseguira acessar o App após realizar a atualização.
Ao clicar no botão atualizar será chamado a função checkPlataformVersion() para verificar qual o sistema instalado no dispositivo, após a identificação, se o sistema for **ANDROID** o mesmo será redirecionado para loja da Play Store, caso seja **IOS** será redirecionado para loja da App Store.
* **TOKEN**: Sua utilidade se dará para autenticar e liberar as chamadas da API.
