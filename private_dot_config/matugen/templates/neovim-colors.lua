-- Material You colorscheme for Neovim generated by matugen

local colors = {
	-- Base surfaces
	bg = "{{colors.surface.default.hex}}",
	bg_dim = "{{colors.surface_dim.default.hex}}",
	bg_bright = "{{colors.surface_bright.default.hex}}",

	-- Container surfaces (for UI elements)
	bg_container_lowest = "{{colors.surface_container_lowest.default.hex}}",
	bg_container_low = "{{colors.surface_container_low.default.hex}}",
	bg_container = "{{colors.surface_container.default.hex}}",
	bg_container_high = "{{colors.surface_container_high.default.hex}}",
	bg_container_highest = "{{colors.surface_container_highest.default.hex}}",

	-- Text colors
	fg = "{{colors.on_surface.default.hex}}",
	fg_variant = "{{colors.on_surface_variant.default.hex}}",

	-- Primary colors
	primary = "{{colors.primary.default.hex}}",
	on_primary = "{{colors.on_primary.default.hex}}",
	primary_container = "{{colors.primary_container.default.hex}}",
	on_primary_container = "{{colors.on_primary_container.default.hex}}",
	primary_fixed = "{{colors.primary_fixed.default.hex}}",
	primary_fixed_dim = "{{colors.primary_fixed_dim.default.hex}}",

	-- Secondary colors
	secondary = "{{colors.secondary.default.hex}}",
	on_secondary = "{{colors.on_secondary.default.hex}}",
	secondary_container = "{{colors.secondary_container.default.hex}}",
	on_secondary_container = "{{colors.on_secondary_container.default.hex}}",
	secondary_fixed = "{{colors.secondary_fixed.default.hex}}",
	secondary_fixed_dim = "{{colors.secondary_fixed_dim.default.hex}}",

	-- Tertiary colors
	tertiary = "{{colors.tertiary.default.hex}}",
	on_tertiary = "{{colors.on_tertiary.default.hex}}",
	tertiary_container = "{{colors.tertiary_container.default.hex}}",
	on_tertiary_container = "{{colors.on_tertiary_container.default.hex}}",
	tertiary_fixed = "{{colors.tertiary_fixed.default.hex}}",
	tertiary_fixed_dim = "{{colors.tertiary_fixed_dim.default.hex}}",

	-- Error colors
	error = "{{colors.error.default.hex}}",
	on_error = "{{colors.on_error.default.hex}}",
	error_container = "{{colors.error_container.default.hex}}",
	on_error_container = "{{colors.on_error_container.default.hex}}",

	-- Other UI elements
	outline = "{{colors.outline.default.hex}}",
	outline_variant = "{{colors.outline_variant.default.hex}}",
	shadow = "{{colors.shadow.default.hex}}",
	scrim = "{{colors.scrim.default.hex}}",

	-- Inverse colors
	inverse_surface = "{{colors.inverse_surface.default.hex}}",
	inverse_on_surface = "{{colors.inverse_on_surface.default.hex}}",
	inverse_primary = "{{colors.inverse_primary.default.hex}}",
}

-- Return the colors table for use in other plugins
return colors
