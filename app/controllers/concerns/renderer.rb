# frozen_string_literal: true

module Renderer
  def compute_form(action, model, form, args = {})
    if form.send(action)
      render data(form.send(model), form, args)
    else
      invalid_resource(form.send(model))
    end
  end

  def data(object, form, args)
    options = {
      include: form.include,
      params: { current_user: }
    }
    {
      json: single_serializer(object, args[:serializer]).new(object, options).serializable_hash.to_json,
      status: :ok
    }
  end

  def file_download(file_path, file_name, file_type)
    send_file(
      file_path,
      type: file_type,
      disposition: 'attachment',
      filename: file_name,
      x_sendfile: true
    )
  end

  def file_preview(data, file_name, file_type)
    send_data(
      data,
      type: file_type,
      disposition: 'inline',
      filename: file_name,
      x_sendfile: true
    )
  end

  # rubocop:disable Style/MissingRespondToMissing
  def method_missing(method_sym, *args, &)
    if method_sym.to_s =~ /^(^[^_]+(?=_))_(.*)_form$/i
      compute_form(Regexp.last_match(1), Regexp.last_match(2), *args)
    else
      super
    end
  end

  # rubocop:enable Style/MissingRespondToMissing

  def single_serializer(obj, serializer)
    serializer.presence || "#{obj.class}Serializer".constantize
  end
end
