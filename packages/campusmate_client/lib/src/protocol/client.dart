/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i3;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i4;
import 'package:campusmate_client/src/protocol/ai_conversations.dart' as _i5;
import 'package:campusmate_client/src/protocol/ai_messages.dart' as _i6;
import 'package:campusmate_client/src/protocol/greetings/greeting.dart' as _i7;
import 'package:campusmate_client/src/protocol/student_profile.dart' as _i8;
import 'protocol.dart' as _i9;

/// Small protected surface used by phase-02 to prove role isolation.
///
/// The real admin feature is delivered in phase-11; keeping this endpoint
/// narrow gives the auth phase a concrete server-side 403 contract now.
/// {@category Endpoint}
class EndpointAdmin extends _i1.EndpointRef {
  EndpointAdmin(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  _i2.Future<String> getAccessSummary() => caller.callServerEndpoint<String>(
    'admin',
    'getAccessSummary',
    {},
  );
}

/// Temporary streaming spike endpoint (phase-08 step 1).
///
/// Proves the Serverpod WebSocket streaming pattern end-to-end — mock token
/// generator on the server, `Stream<String>` on the Flutter client — before
/// the real chat architecture is committed (ADR-008). This endpoint is
/// replaced by the real `AiEndpoint` once the pattern is validated and is
/// removed before phase-08 exits.
/// {@category Endpoint}
class EndpointAiSpike extends _i1.EndpointRef {
  EndpointAiSpike(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'aiSpike';

  /// Streams a mock Vietnamese assistant reply back token-by-token, echoing
  /// the caller's [prompt] so the client can verify round-trip streaming.
  _i2.Stream<String> mockStream(String prompt) =>
      caller.callStreamingServerEndpoint<_i2.Stream<String>, String>(
        'aiSpike',
        'mockStream',
        {'prompt': prompt},
        {},
      );
}

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i3.EndpointEmailIdpBase {
  EndpointEmailIdp(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i2.Future<_i4.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _i2.Future<_i1.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i1.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _i2.Future<String> verifyRegistrationCode({
    required _i1.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _i2.Future<_i4.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _i2.Future<_i1.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i1.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _i2.Future<String> verifyPasswordResetCode({
    required _i1.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i2.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _i2.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i4.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i2.Future<_i4.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// AI assistant endpoints (phase-08): conversation lifecycle, message history,
/// and token-by-token streaming chat backed by [AiProvider].
///
/// Authorization rule (§31): every read/write is scoped to the authenticated
/// user via `session.authenticated.userIdentifier`. A request can never read
/// or write another user's conversation — the `userId` predicate is in every
/// query, so tenant isolation holds even if a client forges an id.
/// {@category Endpoint}
class EndpointAi extends _i1.EndpointRef {
  EndpointAi(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'ai';

  /// Loads the user's conversations, newest first.
  _i2.Future<List<_i5.AiConversation>> listConversations() =>
      caller.callServerEndpoint<List<_i5.AiConversation>>(
        'ai',
        'listConversations',
        {},
      );

  /// Creates a new empty conversation owned by the caller.
  _i2.Future<_i5.AiConversation> createConversation({required String title}) =>
      caller.callServerEndpoint<_i5.AiConversation>(
        'ai',
        'createConversation',
        {'title': title},
      );

  /// Deletes one of the caller's conversations (messages cascade).
  _i2.Future<void> deleteConversation({required int conversationId}) =>
      caller.callServerEndpoint<void>(
        'ai',
        'deleteConversation',
        {'conversationId': conversationId},
      );

  /// Returns the caller's messages for a conversation, oldest first.
  _i2.Future<List<_i6.AiMessage>> getMessages({required int conversationId}) =>
      caller.callServerEndpoint<List<_i6.AiMessage>>(
        'ai',
        'getMessages',
        {'conversationId': conversationId},
      );

  /// Streams an assistant reply to [userMessage] within [conversationId].
  ///
  /// The user message is persisted first; the assistant reply is persisted
  /// (with any citations) once the stream completes. Each emitted String is
  /// one streaming chunk the client appends to the live bubble. The method
  /// return type is `Stream<String>` (not `Future<Stream>`) so Serverpod keeps
  /// the streaming session open. Implemented as an `async*` generator so the
  /// method body can `await` persistence while still returning a
  /// `Stream<String>`.
  _i2.Stream<String> sendMessage({
    required int conversationId,
    required String userMessage,
  }) => caller.callStreamingServerEndpoint<_i2.Stream<String>, String>(
    'ai',
    'sendMessage',
    {
      'conversationId': conversationId,
      'userMessage': userMessage,
    },
    {},
  );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i1.EndpointRef {
  EndpointGreeting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i2.Future<_i7.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i7.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

/// Authenticated student profile operations.
///
/// The endpoint deliberately exposes no user-id parameter. The authenticated
/// session is the only source of ownership for reads and writes.
/// {@category Endpoint}
class EndpointStudentProfile extends _i1.EndpointRef {
  EndpointStudentProfile(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'studentProfile';

  _i2.Future<_i8.StudentProfile> getMyProfile() =>
      caller.callServerEndpoint<_i8.StudentProfile>(
        'studentProfile',
        'getMyProfile',
        {},
      );

  /// Updates the fields that a student may edit themselves.
  ///
  /// Student code, academic results, faculty and major remain server-managed
  /// so client input cannot rewrite institutional data.
  _i2.Future<_i8.StudentProfile> updateMyProfile({
    required String fullName,
    required String className,
  }) => caller.callServerEndpoint<_i8.StudentProfile>(
    'studentProfile',
    'updateMyProfile',
    {
      'fullName': fullName,
      'className': className,
    },
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i3.Caller(client);
    serverpod_auth_core = _i4.Caller(client);
  }

  late final _i3.Caller serverpod_auth_idp;

  late final _i4.Caller serverpod_auth_core;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i9.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    admin = EndpointAdmin(this);
    aiSpike = EndpointAiSpike(this);
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    ai = EndpointAi(this);
    greeting = EndpointGreeting(this);
    studentProfile = EndpointStudentProfile(this);
    modules = Modules(this);
  }

  late final EndpointAdmin admin;

  late final EndpointAiSpike aiSpike;

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointAi ai;

  late final EndpointGreeting greeting;

  late final EndpointStudentProfile studentProfile;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'admin': admin,
    'aiSpike': aiSpike,
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'ai': ai,
    'greeting': greeting,
    'studentProfile': studentProfile,
  };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
