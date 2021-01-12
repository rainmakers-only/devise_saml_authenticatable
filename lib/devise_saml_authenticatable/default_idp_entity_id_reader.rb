module DeviseSamlAuthenticatable
  class DefaultIdpEntityIdReader
    def self.entity_id(params)
      if params[:SAMLRequest]
        OneLogin::RubySaml::SloLogoutrequest.new(
          params[:SAMLRequest],
          settings: Devise.saml_config,
          allowed_clock_drift: Devise.allowed_clock_drift_in_seconds,
          skip_subject_confirmation: true
        ).issuer
      elsif params[:SAMLResponse]
        OneLogin::RubySaml::Response.new(
          params[:SAMLResponse],
          settings: Devise.saml_config,
          allowed_clock_drift: Devise.allowed_clock_drift_in_seconds,
          skip_subject_confirmation: true
        ).issuers.first
      end
    end
  end
end
