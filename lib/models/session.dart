import 'package:firebase_auth/firebase_auth.dart';

import '../common_libs.dart';

class Session with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isAuthenticated = false;

  UserData? _userData;

  Address? _selectedAddress;

  bool get isAuthenticated => _isAuthenticated;

  User? get user => _auth.currentUser;

  UserData? get userData => _userData;

  Address? get selectedAddress => _selectedAddress;

  Future<String?> logout() async {
    try {
      await _auth.signOut();
      _isAuthenticated = false;
      _userData = null;
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      _isAuthenticated = false;
      _userData = null;
      notifyListeners();
      return AuthErrorMessages.getErrorMessage(e.code);
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _isAuthenticated = true;
      notifyListeners();
      await _syncUserData();
      if (_selectedAddress != null) {
        await _syncUserAddress(_selectedAddress!);
      }

      String? token = await _auth.currentUser!.getIdToken();
      debugPrint('Token: $token');
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      _isAuthenticated = false;
      _userData = null;
      notifyListeners();
      return AuthErrorMessages.getErrorMessage(e.code);
    }
  }

  Future<String?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then(
            (value) async => await user!.updateDisplayName(name),
          );
      _isAuthenticated = true;
      notifyListeners();
      await _syncUserData();
      if (_selectedAddress != null) {
        await _syncUserAddress(_selectedAddress!);
      }
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      _isAuthenticated = false;
      _userData = null;
      notifyListeners();
      return AuthErrorMessages.getErrorMessage(e.code);
    }
  }

  Future<String?> requestPasswordReset({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return AuthErrorMessages.getErrorMessage(e.code);
    }
  }

  Future<void> selectAddress(Address address) async {
    _selectedAddress = address;
    await _syncUserAddress(address);
    notifyListeners();
  }

  Future<void> _syncUserAddress(Address address) async {
    _userData?.addAddress(address);
    _userData?.selectAddress(address);
  }

  Future<void> _syncUserData() async {
    _userData = UserData(
      uid: user!.uid,
      displayName: user!.displayName,
      userEmail: user!.email!,
    );
  }
}

class AuthErrorMessages {
  static const String adminRestrictedOperation =
      'Operação restrita a administradores.';
  static const String argumentError = 'Erro no argumento.';
  static const String appNotAuthorized = 'Aplicativo não autorizado.';
  static const String appNotInstalled = 'Aplicativo não instalado.';
  static const String captchaCheckFailed = 'Falha na verificação do captcha.';
  static const String codeExpired = 'Código expirado.';
  static const String cordovaNotReady = 'Cordova não está pronto.';
  static const String corsUnsupported = 'Cors não suportado.';
  static const String customTokenMismatch = 'Token personalizado incompatível.';
  static const String requiresRecentLogin =
      'A operação é sensível e requer autenticação recente. Faça login novamente antes de tentar novamente esta solicitação.';
  static const String dependentSdkInitializedBeforeAuth =
      'O SDK dependente foi inicializado antes de Auth.';
  static const String dynamicLinkNotActivated = 'Link dinâmico não ativado.';
  static const String emailChangeNeedsVerification =
      'O e-mail foi alterado, mas a verificação é necessária.';
  static const String emailAlreadyInUse =
      'O endereço de e-mail já está em uso. Faça login eu tente redefinir a sua senha';
  static const String emulatorConfigFailed =
      'Falha na configuração do emulador.';
  static const String expiredActionCode = 'Código de ação expirado.';
  static const String cancelledPopupRequest =
      'Solicitação de pop-up cancelada.';
  static const String internalError = 'Erro interno.';
  static const String invalidApiKey = 'Chave de API inválida.';
  static const String invalidAppCredential =
      'Credencial de aplicativo inválida.';
  static const String invalidAppId = 'ID do aplicativo inválido.';
  static const String invalidUserToken = 'Token de usuário inválido.';
  static const String invalidAuthEvent = 'Evento de autenticação inválido.';
  static const String invalidCertHash = 'Hash de certificado inválido.';
  static const String invalidVerificationCode =
      'Código de verificação inválido.';
  static const String invalidContinueUri = 'URI de continuação inválida.';
  static const String invalidCordovaConfiguration =
      'Configuração do Cordova inválida.';
  static const String invalidCustonToken = 'Token personalizado inválido.';
  static const String invalidDynamicLinkDomain =
      'Domínio de link dinâmico inválido.';
  static const String invalidEmail = 'E-mail inválido.';
  static const String invalidEmulatorScheme = 'Esquema de emulador inválido.';
  static const String invalidCredential = 'Usuário ou senha inválidos.';
  static const String invalidMessagePayload =
      'Carga útil da mensagem inválida.';
  static const String invalidMultiFactorSession =
      'Sessão de vários fatores inválida.';
  static const String invalidOauthClientId = 'ID do cliente OAuth inválido.';
  static const String invalidOauthProvider = 'Provedor OAuth inválido.';
  static const String invalidActionCode = 'Código de ação inválido.';
  static const String unauthorizedDomain = 'Domínio não autorizado.';
  static const String wrongPassword = 'Senha incorreta.';
  static const String invalidPersistenceType = 'Tipo de persistência inválido.';
  static const String invalidPhoneNumber = 'Número de telefone inválido.';
  static const String invalidProviderId = 'ID do provedor inválido.';
  static const String invalidRecipientEmail =
      'E-mail do destinatário inválido.';
  static const String invalidSender = 'Remetente inválido.';
  static const String invalidVerificationId = 'ID de verificação inválido.';
  static const String invalidTenantId = 'ID do locatário inválido.';
  static const String multiFactorInfoNotFound =
      'Informações de vários fatores não encontradas.';
  static const String multiFactorAuthRequired =
      'Autenticação de vários fatores necessária.';
  static const String missingAndroidPkgName = 'Nome do pacote Android ausente.';
  static const String missingAppCredential =
      'Credencial do aplicativo ausente.';
  static const String authDomainConfigRequired =
      'Configuração de domínio de autenticação necessária.';
  static const String missingVerificationCode =
      'Código de verificação ausente.';
  static const String missingContinueUri = 'URI de continuação ausente.';
  static const String missingIframeStart = 'Início do iframe ausente.';
  static const String missingIosBundleId = 'ID do pacote iOS ausente.';
  static const String missingOrInvalidNonce = 'Nonce ausente ou inválido.';
  static const String missingMultiFactorInfo =
      'Informações de vários fatores ausentes.';
  static const String missingMultiFactorSession =
      'Sessão de vários fatores ausente.';
  static const String missingPhoneNumber = 'Número de telefone ausente.';
  static const String missingVerificationId = 'ID de verificação ausente.';
  static const String appDeleted = 'Aplicativo excluído.';
  static const String accountExistsWithDifferentCredential =
      'Já existe uma conta com o mesmo endereço de e-mail, mas com credenciais de login diferentes. Faça login usando um provedor associado a este endereço de e-mail.';
  static const String networkRequestFailed = 'Falha na solicitação de rede.';
  static const String nullUser = 'Usuário nulo.';
  static const String noAuthEvent = 'Nenhum evento de autenticação.';
  static const String noSuchProvider = 'Nenhum provedor.';
  static const String operationNotAllowed = 'Operação não permitida.';
  static const String operationNotSupportedInThisEnvironment =
      'Operação não suportada neste ambiente.';
  static const String popupBlocked = 'Pop-up bloqueado.';
  static const String popupClosedByUser = 'Pop-up fechado pelo usuário.';
  static const String providerAlreadyLinked =
      'O usuário já está vinculado ao provedor.';
  static const String quotaExceeded = 'Cota excedida.';
  static const String redirectCancelledByUser =
      'Redirecionamento cancelado pelo usuário.';
  static const String redirectOperationPending = 'Redirecionamento pendente.';
  static const String rejectedCredential = 'Credencial rejeitada.';
  static const String secondFactorAlreadyInUse =
      'O segundo fator já está em uso.';
  static const String maximumSecondFactorCountExceeded =
      'Contagem máxima excedida.';
  static const String tenantIdMismatch = 'ID do locatário incompatível.';
  static const String timeout = 'Tempo esgotado.';
  static const String userTokenExpired = 'Token de usuário expirado.';
  static const String tooManyRequests = 'Muitas solicitações.';
  static const String unauthorizedContinueUri =
      'URI de continuação não autorizada.';
  static const String unsupportedFirstFactor = 'Primeiro fator não suportado.';
  static const String unsupportedPersistenceType =
      'Tipo de persistência não suportado.';
  static const String unsupportedTenantOperation =
      'Operação de locatário não suportada.';
  static const String unverifiedEmail = 'E-mail não verificado.';
  static const String userCancelled = 'Usuário cancelado.';
  static const String userNotFound = 'Usuário não encontrado.';
  static const String userDisabled = 'Usuário desativado.';
  static const String userMismatch = 'Usuário incompatível.';
  static const String userSignOut = 'Usuário desconectado.';
  static const String weakPassword = 'Senha fraca.';
  static const String webStorageUnsupported =
      'Armazenamento da web não suportado.';
  static const String alreadyInitialized = 'Já inicializado.';
  static const String recaptchaNotEnabled = 'Recaptcha não ativado.';
  static const String missingRecaptchaToken = 'Token Recaptcha ausente.';
  static const String invalidRecaptchaToken = 'Token Recaptcha inválido.';
  static const String invalidRecaptchaAction = 'Ação Recaptcha inválida.';
  static const String missingClientType = 'Tipo de cliente ausente.';
  static const String missingRecaptchaVersion = 'Versão Recaptcha ausente.';
  static const String invalidRecaptchaVersion = 'Versão Recaptcha inválida.';
  static const String invalidReqType = 'Tipo de solicitação inválido.';

  static String? getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'admin-restricted-operation':
        return adminRestrictedOperation;
      case 'argument-error':
        return argumentError;
      case 'app-not-authorized':
        return appNotAuthorized;
      case 'app-not-installed':
        return appNotInstalled;
      case 'captcha-check-failed':
        return captchaCheckFailed;
      case 'code-expired':
        return codeExpired;
      case 'cordova-not-ready':
        return cordovaNotReady;
      case 'cors-unsupported':
        return corsUnsupported;
      case 'custom-token-mismatch':
        return customTokenMismatch;
      case 'requires-recent-login':
        return requiresRecentLogin;
      case 'dependent-sdk-initialized-before-auth':
        return dependentSdkInitializedBeforeAuth;
      case 'dynamic-link-not-activated':
        return dynamicLinkNotActivated;
      case 'email-change-needs-verification':
        return emailChangeNeedsVerification;
      case 'email-already-in-use':
        return emailAlreadyInUse;
      case 'emulator-config-failed':
        return emulatorConfigFailed;
      case 'expired-action-code':
        return expiredActionCode;
      case 'cancelled-popup-request':
        return cancelledPopupRequest;
      case 'internal-error':
        return internalError;
      case 'invalid-api-key':
        return invalidApiKey;
      case 'invalid-app-credential':
        return invalidAppCredential;
      case 'invalid-app-id':
        return invalidAppId;
      case 'invalid-user-token':
        return invalidUserToken;
      case 'invalid-auth-event':
        return invalidAuthEvent;
      case 'invalid-cert-hash':
        return invalidCertHash;
      case 'invalid-verification-code':
        return invalidVerificationCode;
      case 'invalid-continue-uri':
        return invalidContinueUri;
      case 'invalid-cordova-configuration':
        return invalidCordovaConfiguration;
      case 'invalid-custom-token':
        return invalidCustonToken;
      case 'invalid-dynamic-link-domain':
        return invalidDynamicLinkDomain;
      case 'invalid-email':
        return invalidEmail;
      case 'invalid-emulator-scheme':
        return invalidEmulatorScheme;
      case 'invalid-credential':
        return invalidCredential;
      case 'invalid-message-payload':
        return invalidMessagePayload;
      case 'invalid-multi-factor-session':
        return invalidMultiFactorSession;
      case 'invalid-oauth-client-id':
        return invalidOauthClientId;
      case 'invalid-oauth-provider':
        return invalidOauthProvider;
      case 'invalid-action-code':
        return invalidActionCode;
      case 'unauthorized-domain':
        return unauthorizedDomain;
      case 'wrong-password':
        return wrongPassword;
      case 'invalid-persistence-type':
        return invalidPersistenceType;
      case 'invalid-phone-number':
        return invalidPhoneNumber;
      case 'invalid-provider-id':
        return invalidProviderId;
      case 'invalid-recipient-email':
        return invalidRecipientEmail;
      case 'invalid-sender':
        return invalidSender;
      case 'invalid-verification-id':
        return invalidVerificationId;
      case 'invalid-tenant-id':
        return invalidTenantId;
      case 'multi-factor-info-not-found':
        return multiFactorInfoNotFound;
      case 'multi-factor-auth-required':
        return multiFactorAuthRequired;
      case 'missing-android-pkg-name':
        return missingAndroidPkgName;
      case 'missing-app-credential':
        return missingAppCredential;
      case 'auth-domain-config-required':
        return authDomainConfigRequired;
      case 'missing-verification-code':
        return missingVerificationCode;
      case 'missing-continue-uri':
        return missingContinueUri;
      case 'missing-iframe-start':
        return missingIframeStart;
      case 'missing-ios-bundle-id':
        return missingIosBundleId;
      case 'missing-or-invalid-nonce':
        return missingOrInvalidNonce;
      case 'missing-multi-factor-info':
        return missingMultiFactorInfo;
      case 'missing-multi-factor-session':
        return missingMultiFactorSession;
      case 'missing-phone-number':
        return missingPhoneNumber;
      case 'missing-verification-id':
        return missingVerificationId;
      case 'app-deleted':
        return appDeleted;
      case 'account-exists-with-different-credential':
        return accountExistsWithDifferentCredential;
      case 'network-request-failed':
        return networkRequestFailed;
      case 'null-user':
        return nullUser;
      case 'no-auth-event':
        return noAuthEvent;
      case 'no-such-provider':
        return noSuchProvider;
      case 'operation-not-allowed':
        return operationNotAllowed;
      case 'operation-not-supported-in-this-environment':
        return operationNotSupportedInThisEnvironment;
      case 'popup-blocked':
        return popupBlocked;
      case 'popup-closed-by-user':
        return popupClosedByUser;
      case 'provider-already-linked':
        return providerAlreadyLinked;
      case 'quota-exceeded':
        return quotaExceeded;
      case 'redirect-cancelled-by-user':
        return redirectCancelledByUser;
      case 'redirect-operation-pending':
        return redirectOperationPending;
      case 'rejected-credential':
        return rejectedCredential;
      case 'second-factor-already-in-use':
        return secondFactorAlreadyInUse;
      case 'maximum-second-factor-count-exceeded':
        return maximumSecondFactorCountExceeded;
      case 'tenant-id-mismatch':
        return tenantIdMismatch;
      case 'timeout':
        return timeout;
      case 'user-token-expired':
        return userTokenExpired;
      case 'too-many-requests':
        return tooManyRequests;
      case 'unauthorized-continue-uri':
        return unauthorizedContinueUri;
      case 'unsupported-first-factor':
        return unsupportedFirstFactor;
      case 'unsupported-persistence-type':
        return unsupportedPersistenceType;
      case 'unsupported-tenant-operation':
        return unsupportedTenantOperation;
      case 'unverified-email':
        return unverifiedEmail;
      case 'user-cancelled':
        return userCancelled;
      case 'user-not-found':
        return userNotFound;
      case 'user-disabled':
        return userDisabled;
      case 'user-mismatch':
        return userMismatch;
      case 'user-signed-out':
        return userSignOut;
      case 'weak-password':
        return weakPassword;
      case 'web-storage-unsupported':
        return webStorageUnsupported;
      case 'already-initialized':
        return alreadyInitialized;
      case 'recaptcha-not-enabled':
        return recaptchaNotEnabled;
      case 'missing-recaptcha-token':
        return missingRecaptchaToken;
      case 'invalid-recaptcha-token':
        return invalidRecaptchaToken;
      case 'invalid-recaptcha-action':
        return invalidRecaptchaAction;
      case 'missing-client-type':
        return missingClientType;
      case 'missing-recaptcha-version':
        return missingRecaptchaVersion;
      case 'invalid-recaptcha-version':
        return invalidRecaptchaVersion;
      case 'invalid-req-type':
        return invalidReqType;

      default:
        return null; // Retorne null se o código de erro não for reconhecido.
    }
  }
}
